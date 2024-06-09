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
import 'package:ez_english/presentation/common/objects/part_object.dart';

class SpeakingQuestionPage extends StatefulWidget {
  final PartObject part;
  final Duration timeLimit;
  final int numOfQuestion;

  const SpeakingQuestionPage(
      {super.key,
      required this.part,
      required this.timeLimit,
      required this.numOfQuestion});

  @override
  _SpeakingQuestionPageState createState() => _SpeakingQuestionPageState();
}

class _SpeakingQuestionPageState extends State<SpeakingQuestionPage> {
  late GlobalKey<_SpeakingQuestionPageBodyState> _pageBodyKey;

  @override
  void initState() {
    // tắt phát âm khi thoát khỏi màn hình
    _pageBodyKey = GlobalKey<_SpeakingQuestionPageBodyState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: supabase
            .from("speaking_question")
            .select()
            .eq('part_id', widget.part.index + 7),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.length < widget.numOfQuestion) {
            return Center(
                child: Text('Not enough questions',
                    style: getBoldStyle(color: Colors.black, fontSize: 20)));
          }
          snapshot.data!.shuffle();
          List<Map<String, dynamic>> questionList = [];
          for (int i = 0; i < widget.numOfQuestion; i++) {
            questionList.add(snapshot.data![i]);
          }
          return Scaffold(
            body: Column(children: <Widget>[
              GradientAppBar(
                content: '',
                prefixIcon: InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      _pageBodyKey.currentState
                          ?.reset(); // tắt phát âm khi thoát khỏi màn hình
                      Navigator.pushNamed(
                          context, RoutesName.skillPracticeRoute,
                          arguments: 'Speaking');
                    }),
              ),
              (widget.timeLimit.inSeconds > 0)
                  ? TimeCounter(
                      timeLimit: widget.timeLimit,
                      navigateToNextPage: () {},
                    )
                  : Container(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpeakingQuestionPageBody(
                    key: _pageBodyKey,
                    questionList: questionList,
                    partIndex: widget.part.index,
                  ),
                ),
              ),
            ]),
          );
        });
  }
}

class SpeakingQuestionPageBody extends StatefulWidget {
  List<Map<String, dynamic>> questionList;
  int partIndex;

  SpeakingQuestionPageBody(
      {super.key, required this.questionList, required this.partIndex});

  @override
  _SpeakingQuestionPageBodyState createState() =>
      _SpeakingQuestionPageBodyState();
}

class _SpeakingQuestionPageBodyState extends State<SpeakingQuestionPageBody> {
  int _currentRecordingState = 0;
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';
  final PageController _pageController = PageController();
  String _answer = '';
  List<Map<bool, String>> isCorrectList = [];
  FlutterTts flutterTts = FlutterTts();
  bool _isTTSSpeaking = false;
  bool _isAudio = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    for (int i = 0; i < widget.questionList.length; i++) {
      isCorrectList.add({false: '...'});
    }
  }

  @override
  void dispose() {
    _speechToText.cancel();
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
    return text
        .toLowerCase()
        .replaceAll('-', ' ')
        .replaceAll(RegExp(r'[^\w\s]'), '');
  }

  void _stopListening() async {
    await _speechToText.stop();

    setState(() {
      if (simplifyText(_lastWords) == simplifyText(_answer)) {
        _currentRecordingState = 3;
        isCorrectList[_pageController.page!.round()] = {true: _lastWords};
      } else {
        isCorrectList[_pageController.page!.round()] = {false: _lastWords};
        _lastWords = '';
        _currentRecordingState = 2;
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
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.explanation,
                style: getBoldStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                explanation,
                style: getMediumStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  void reset() {
    _currentRecordingState = 0;
    _lastWords = '';
    _isTTSSpeaking = false;
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questionList.length,
      itemBuilder: (context, index) {
        late Widget questionContent;
        final question = widget.questionList[index];

        _answer = question['answer'];

        if (question['imageUrl'] != null) {
          questionContent = ImageBox(question['imageUrl']);
        } else if (question['audioUrl'] != null) {
          questionContent = TrackBarBox(question['audioUrl']);
          _isAudio = true;
        } else {
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
            _isAudio == false
                ? FilledButton(
                    onPressed: () {
                      if (_isTTSSpeaking) {
                        flutterTts.stop();
                        _isTTSSpeaking = false;
                      } else {
                        flutterTts.speak(_answer);
                        _isTTSSpeaking = true;
                      }
                    },
                    style: FilledButton.styleFrom(
                      fixedSize: const Size(40, 30),
                    ),
                    child: const Icon(
                      Icons.volume_up_sharp,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(height: 0),
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
                      if (_speechToText.isNotListening) {
                        _currentRecordingState = 1;
                        _startListening();
                      } else {
                        _stopListening();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(60, 60),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          gradient: ColorManager.linearGradientPrimary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 48,
                        ))),
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                question['explanation'] != null
                    ? showExplanation(question['explanation'])
                    : showExplanation(
                        AppLocalizations.of(context)!.not_update_yet);
              },
              child: Text(
                AppLocalizations.of(context)!.explanation,
              ),
            ),
            const SizedBox(height: 10),
            CommonButton(
                text: AppLocalizations.of(context)!.next,
                action: () {
                  reset();
                  if (index == widget.questionList.length - 1) {
                    Navigator.pushNamed(context, RoutesName.speakingResultRoute,
                        arguments: [isCorrectList, widget.partIndex]);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                }),
          ],
        );
      },
    );
  }
}

class TextBox extends StatelessWidget {
  final String text;

  TextBox(this.text);

  @override
  Widget build(BuildContext context) {
    print(text);
    return Column(children: <Widget>[
      const SizedBox(height: 60),
      Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Center(
          child: Text(
            text,
            style: getMediumStyle(color: Colors.black, fontSize: 12),
            maxLines: 20,
          ),
        ),
      ),
      const SizedBox(height: 60),
    ]);
  }
}

class ImageBox extends StatelessWidget {
  final String imageUrl;

  ImageBox(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 30),
      Container(
        height: 255,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.scaleDown, image: NetworkImage(imageUrl)),
        ),
      ),
      const SizedBox(height: 30),
    ]);
  }
}

class TrackBarBox extends StatefulWidget {
  final String audioUrl;

  TrackBarBox(this.audioUrl);

  @override
  _TrackBarBoxState createState() => _TrackBarBoxState();
}

class _TrackBarBoxState extends State<TrackBarBox> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 60),
      TrackBar(audioUrl: widget.audioUrl),
      const SizedBox(height: 60),
    ]);
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
    if (widget.index == 0) {
      return Text(
        AppLocalizations.of(context)!.press,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    } else if (widget.index == 1) {
      return Text(
        AppLocalizations.of(context)!.recording,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    } else if (widget.index == 2) {
      return Text(
        AppLocalizations.of(context)!.incorrect_try_again,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    } else {
      return Text(
        AppLocalizations.of(context)!.correct,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
  }
}
