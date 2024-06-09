import 'dart:typed_data';

import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/presentation/blocs/app_language/language_changing_cubit.dart';
import 'package:ez_english/config/constants.dart';

class WritingQuestionPage extends StatefulWidget {
  final PartObject part;
  final int limit;

  const WritingQuestionPage(
      {super.key, required this.part, required this.limit});

  @override
  State<WritingQuestionPage> createState() => _WritingQuestionPageState();
}

class _WritingQuestionPageState extends State<WritingQuestionPage> {
  AppPrefs appPrefs = GetIt.instance<AppPrefs>();
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = appPrefs.getAppLanguage() ?? DEFAULT_LANG_CODE;
    print(widget.part.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WritingQuestionBody(
                  part: widget.part,
                  limit: widget.limit,
                  selectedLanguage: _selectedLanguage),
            ),
          ],
        ));
  }
}

class WritingQuestionBody extends StatefulWidget {
  final PartObject part;
  final int limit;
  final String selectedLanguage;
  const WritingQuestionBody(
      {super.key,
      required this.part,
      required this.limit,
      required this.selectedLanguage});

  @override
  State<WritingQuestionBody> createState() => _WritingQuestionBodyState();
}

class _WritingQuestionBodyState extends State<WritingQuestionBody> {
  final PageController _pageController = PageController();
  int partIndex = 0;
  List<dynamic> questions = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await Supabase.instance.client
        .from('part')
        .select('id')
        .eq('part_index', widget.part.index)
        .eq('skill', 'Writing')
        .single();

    setState(() {
      partIndex = response['id'];
    });

    final response1 = await Supabase.instance.client
        .from('question')
        .select()
        .eq('part_id', partIndex)
        .limit(widget.limit);

    setState(() {
      questions = response1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return QuestionPage(
          index: index,
          partIndex: partIndex,
          language: widget.selectedLanguage,
          imageUrl: question['imageurl'],
          questionText: question['questions'][0],
          explanation: question['answers'][0]['explanation'],
          correctAnswer: question['answers'][0]['correct_answer'],
          onNext: () {
            if (index < questions.length - 1) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class QuestionPage extends StatefulWidget {
  final int index;
  final int partIndex;
  final String? imageUrl;
  final String questionText;
  final String explanation;
  final String language;
  final int correctAnswer;
  final VoidCallback onNext;

  const QuestionPage({
    Key? key,
    this.imageUrl,
    required this.questionText,
    required this.explanation,
    required this.correctAnswer,
    required this.onNext,
    required this.index,
    required this.language,
    required this.partIndex,
  }) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final TextEditingController answerController = TextEditingController();
  bool isLoading = false;
  final gemini = Gemini.instance;

  Future<String> testGemini() async {
    if (widget.partIndex == 13) {
      final response = await gemini.text(
        "This is a writing question test, with image. The detail of image is ${widget.explanation}. The question is ${widget.questionText}, and the user answer is ${answerController.text}. Please check grammar ${answerController.text} and if it matching to the image detail, give user suggestion on how to improve. Translate the result into ${widget.language} language.",
      );
      return response?.content?.parts?.last.text ?? '';
    } else if (widget.partIndex == 14) {
      final response = await gemini.text(
        "This is a writing question test. The requirement is ${widget.explanation}. The question is ${widget.questionText}, and the user answer reply to the question is ${answerController.text}. Please check grammar ${answerController.text} and give user suggestion on how to improve about their writing. Translate the result into ${widget.language} language.",
      );
      return response?.content?.parts?.last.text ?? '';
    }
    return '';
  }

  void handleSubmit() async {
    if (answerController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.error),
          content: Text(AppLocalizations.of(context)!.please_enter_answer),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.got_it),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    FocusScope.of(context).unfocus();

    final geminiAnswer = await testGemini();

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultWritingPage(
          geminiAnswer: geminiAnswer,
          imageUrl: widget.imageUrl ?? '',
          question: widget.questionText,
          onNext: widget.onNext,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              GradientAppBar(
                content: '',
                prefixIcon: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.explanation),
                        content: Text(widget.explanation),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(AppLocalizations.of(context)!.got_it),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.explanation,
                    style: getMediumStyle(color: Colors.white).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)?.question} ${widget.index + 1}',
                        style: getBoldStyle(color: Colors.black, fontSize: 14),
                      ),
                      widget.imageUrl != ''
                          ? Container(
                              height: 255,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  scale: 1.5,
                                  fit: BoxFit.scaleDown,
                                  image: NetworkImage(widget.imageUrl ?? ''),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: widget.questionText,
                              style: getBoldStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: answerController,
                      maxLines: 5,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)?.enter_answer,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    CommonButton(
                      action: handleSubmit,
                      text: AppLocalizations.of(context)!.confirm,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black45,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class ResultWritingPage extends StatelessWidget {
  final String geminiAnswer;
  final String? imageUrl;
  final String question;
  final VoidCallback onNext;

  ResultWritingPage({
    Key? key,
    required this.geminiAnswer,
    required this.onNext,
    required this.imageUrl,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GradientAppBar(
            content: AppLocalizations.of(context)!.answer_correction,
            prefixIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(children: [
                imageUrl != ''
                    ? Container(
                        height: 255,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              scale: 1.5,
                              fit: BoxFit.scaleDown,
                              image: NetworkImage(imageUrl ?? '')),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: question,
                        style: getBoldStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: _parseGeminiAnswer(geminiAnswer),
                  ),
                ),
              ]),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonButton(
                  text: AppLocalizations.of(context)!.app_continue,
                  action: onNext)),
        ],
      ),
    );
  }

  List<TextSpan> _parseGeminiAnswer(String text) {
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(r"\*\*(.*?)\*\*");
    int lastIndex = 0;

    for (final Match match in exp.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }
    return spans;
  }
}
