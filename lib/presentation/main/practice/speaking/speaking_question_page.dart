import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/time_counter.dart';
import 'package:ez_english/presentation/main/practice/widgets/track_bar.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';

class SpeakingQuestion {
  final int id;
  final String? answer;
  final String? imageUrl;
  final String? audioUrl;
  final String? explanation;
  final int part_id;

  SpeakingQuestion({
    required this.id,
    this.answer,
    this.imageUrl,
    this.audioUrl,
    this.explanation,
    required this.part_id,
  });
}

Future<void> insertHistoryRecord(String skill, int part) async {
  supabase.from('history').insert({
    'skill': skill,
    'part': part,
    'by_uuid': supabase.auth.currentUser?.id,
  });
}

class SpeakingQuestionPage extends StatefulWidget {
  final int part;

  const SpeakingQuestionPage({super.key, required this.part});

  @override
  _SpeakingQuestionPageState createState() => _SpeakingQuestionPageState();
}

class _SpeakingQuestionPageState extends State<SpeakingQuestionPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _future = supabase.from("speaking_question").select().eq("part_id", widget.part);

    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }    
        return Scaffold(
          body: Column(
            children: <Widget>[
              GradientAppBar(
                content: '',
                prefixIcon: InkWell(
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onTap: () {
                    insertHistoryRecord('Speaking', widget.part);
                    Navigator.pushNamed(
                      context, RoutesName.skillPracticeRoute, 
                      arguments: 'Speaking'
                    );
                  }
                ),
              ),
              const TimeCounter(timeLimit: Duration(minutes: 3)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpeakingQuestionPageBody(
                    questionList: snapshot.data!,
                  ),
                ),
              ),
            ]
          ),
        );
      }
    );
  }
}

class SpeakingQuestionPageBody extends StatefulWidget {
  List<Map<String, dynamic>> questionList;

  SpeakingQuestionPageBody({super.key, required this.questionList});

  @override
  _SpeakingQuestionPageBodyState createState() => _SpeakingQuestionPageBodyState();
}

class _SpeakingQuestionPageBodyState extends State<SpeakingQuestionPageBody> {
  int _currentRecordingIndex = 0;
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  final PageController _pageController = PageController();
  String _answer = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {   
    setState(() {
      _speechToText.initialize();
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      if (_lastWords.toLowerCase() == _answer.toLowerCase()) {
        _currentRecordingIndex = 3;
      } else {
        _currentRecordingIndex = 2;
      }
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void showExplanation(String explanation) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.6,
            child: Text(
              explanation,
              style: getRegularStyle(color: Colors.black),
              maxLines: 100,
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questionList.length,
      itemBuilder: (context, index) {
        late Widget questionContent;
        final question = widget.questionList[index];
        _answer = question['answer'] ?? '';

        if (question['imageUrl'] != null)
        {
          questionContent = ImageBox(question['imageUrl']);
        }
        else if (question['audioUrl'] != null)
        {
          questionContent = TrackBarBox(question['audioUrl']);
        }
        else
        {
          questionContent = TextBox(_answer);
        }

        return ListView(
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context)!.question} ${index + 1}',
              maxLines: 100,
              style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                questionContent,
                Text(_speechToText.isListening ? _lastWords : ''),
                const SizedBox(height: 5),
                RecordingAttribute(_currentRecordingIndex),
                const SizedBox(height: 20),          
                ElevatedButton(
                  onPressed: () {
                    if (_speechToText.isNotListening) 
                    {
                      _currentRecordingIndex = 1;
                      _startListening();
                    } 
                    else
                    {
                      _stopListening();
                    }
                  },        
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 100),
                    padding: const EdgeInsets.all(0),    
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: ColorManager.linearGradientPrimary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 80,
                    )
                  )
                ),
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                showExplanation(question['explanation'] ??
                    AppLocalizations.of(context)!.not_update_yet);
              },
              child: Text(AppLocalizations.of(context)!.explanation)
            ),
            const SizedBox(height: 10),
            CommonButton(
              text: AppLocalizations.of(context)!.next, 
              action: () {
                if (index == widget.questionList.length - 1) {
                  Navigator.pop(context);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
            ),
          ],
        );
      },
    );
  }
}

class TextBox extends StatelessWidget {
  final String wordsToPronounce;

  TextBox(this.wordsToPronounce);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 150),
        Text(
          wordsToPronounce,
          style: getSemiBoldStyle(color: Colors.black, fontSize: 30),
        ),
        const SizedBox(height: 135),
      ]
    );
  }
}

class ImageBox extends StatelessWidget {
  final String imageUrl;

  ImageBox(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          height: 255,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: NetworkImage(imageUrl)),
          ),
        ),
        const SizedBox(height: 30),
      ]
    );
  }
}

class TrackBarBox extends StatelessWidget {
  final String audioUrl;

  TrackBarBox(this.audioUrl);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 142),
        TrackBar(audioUrl: audioUrl),
        const SizedBox(height: 142),
      ]
    );
  }
}

class RecordingAttribute extends StatefulWidget {
  int index;

  RecordingAttribute(this.index);

  @override
  _RecordingAttributeState createState() => _RecordingAttributeState();
}

class _RecordingAttributeState extends State<RecordingAttribute> {
  @override
  Widget build(BuildContext context) {
    if (widget.index == 0)
    { 
      return Text(
        AppLocalizations.of(context)!.press,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      ); 
    }
    else if (widget.index == 1)
    {
      return Text(
        AppLocalizations.of(context)!.recording,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
    else if (widget.index == 2)
    {
      return Text(
        AppLocalizations.of(context)!.incorrect_try_again,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
    else
    {
      return Text(
        AppLocalizations.of(context)!.correct,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
  }
}

