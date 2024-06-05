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
import 'package:flutter_tts/flutter_tts.dart';  
import '../../../../config/functions.dart';

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
    return FutureBuilder(
      future: supabase.from("speaking_question").select().eq("part_id", widget.part),
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
                    part: widget.part,
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
  int part;

  SpeakingQuestionPageBody({super.key, required this.questionList, required this.part});

  @override
  _SpeakingQuestionPageBodyState createState() => _SpeakingQuestionPageBodyState();
}

class _SpeakingQuestionPageBodyState extends State<SpeakingQuestionPageBody> {
  int _currentRecordingState = 0;
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  final PageController _pageController = PageController();
  String _answer = ''; 
  List<bool> isCorrectList = [];
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    for (int i = 0; i < widget.questionList.length; i++) {
      isCorrectList.add(false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  String simplifyText(String text) {
    return text.toLowerCase().replaceAll('-', ' ').replaceAll(RegExp(r'[^\w\s]'), '');
  }

  void _stopListening() async {
    await _speechToText.stop();

    setState(() {
      if (simplifyText(_lastWords) == simplifyText(_answer)) {
        _currentRecordingState = 3;
        isCorrectList[_pageController.page!.round()] = true;
      } 
      else 
      {
        _lastWords = '';
        _currentRecordingState = 2;
        isCorrectList[_pageController.page!.round()] = false;
      }
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questionList.length,
      itemBuilder: (context, index) {
        late Widget questionContent;
        Map<String, dynamic> question = widget.questionList[index];

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
            FilledButton(
              onPressed: () {
                flutterTts.speak(_answer);
              },
              style: FilledButton.styleFrom(
                fixedSize: const Size(40, 30), 
              ),
              child: const Icon(
                Icons.volume_up_sharp,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: <Widget>[
                questionContent,
                Text(_speechToText.isListening ? _lastWords : ''),
                const SizedBox(height: 5),
                RecordingAttribute(_currentRecordingState),
                const SizedBox(height: 20),          
                ElevatedButton(
                  onPressed: () {
                    if (_speechToText.isNotListening) 
                    {
                      _currentRecordingState = 1;
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
                showExplanation(
                      question['explanation'] ??
                        AppLocalizations.of(context)!.not_update_yet,
                        context);
              },
              child: Text(
                AppLocalizations.of(context)!.explanation,
              ),
            ),
            const SizedBox(height: 10),
            CommonButton(
              text: AppLocalizations.of(context)!.next, 
              action: () {
                if (index == widget.questionList.length - 1) {
                  Navigator.pushNamed(context, RoutesName.speakingResultRoute,
                  arguments: [isCorrectList, widget.part]);
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

