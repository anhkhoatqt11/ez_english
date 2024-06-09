import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/domain/model/test_question.dart';
import 'package:ez_english/presentation/main/practice/widgets/question_container.dart';
import 'package:ez_english/presentation/main/practice/widgets/track_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../config/functions.dart';

class TestQuestionBody extends StatefulWidget {
  TestQuestionBody(
      {super.key, required this.answerMap, required this.questionList});
  Map<int, String> answerMap;
  List<TestQuestion> questionList;
  @override
  _TestQuestionBodyState createState() => _TestQuestionBodyState();
}

class _TestQuestionBodyState extends State<TestQuestionBody>
    with ChangeNotifier {
  final PageController _pageController = PageController();
  final appPrefs = GetIt.instance<AppPrefs>();
  late bool isHorizontal;
  late Map<int, String> _answers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _answers = widget.answerMap;
    isHorizontal = appPrefs.getHorizontalAnswerBarLayout() ?? false;
    addListener(_checkCurrentPageAnswers);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    removeListener(_checkCurrentPageAnswers);

    Future.delayed(Duration.zero);
    super.dispose();
  }

  Future<void> _checkCurrentPageAnswers() async {
    print("I'm checking !");
    print(_answers);
    int currentIndex = _pageController.page!.round();
    List<String?> currentPageAnswers =
        widget.questionList[currentIndex].question.asMap().entries.map((entry) {
      print(entry.key);
      print(_getQuestionStartIndex(currentIndex));

      return _answers[entry.key + _getQuestionStartIndex(currentIndex) + 1];
    }).toList();
    if (currentPageAnswers.every((answer) => answer != null)) {
      if (currentIndex < widget.questionList.length) {
        await Future.delayed(const Duration(milliseconds: 500));
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  void _updateAnswer(int questionIndex, String answer) {
    _answers[questionIndex] = answer;
    notifyListeners();
  }

  int _getQuestionStartIndex(int pageIndex) {
    int startIndex = 0;
    for (int i = 0; i < pageIndex; i++) {
      startIndex += widget.questionList[i].question.length;
    }
    return startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questionList.length,
      itemBuilder: (context, index) {
        TestQuestion question = widget.questionList[index];
        int questionStartIndex = _getQuestionStartIndex(index);
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    FilledButton(
                      onPressed: () {
                        showExplanation(question.answer, context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.explanation,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    question.imageUrl != null
                        ? Container(
                            height: 255,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.scaleDown,
                                  image: NetworkImage(question.imageUrl ?? '')),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 32,
                    ),
                    question.audioUrl != null
                        ? TrackBar(audioUrl: question.audioUrl!)
                        : Container(),
                    isHorizontal
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: question.question
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int questionIndex =
                                    entry.key + questionStartIndex + 1;
                                String questionText = entry.value;
                                String? selectedAnswer =
                                    _answers[questionIndex];
                                return QuestionContainer(
                                  isTest: true,
                                  answer: question.answer[entry.key],
                                  questionText: questionText,
                                  selectedAnswer: selectedAnswer,
                                  questionIndex: questionIndex,
                                  onAnswerSelected: (answer) {
                                    _updateAnswer(questionIndex, answer);
                                  },
                                );
                              }).toList(),
                            )),
                  ],
                ),
              ),
            ),
            /*HorizontalAnswerBar(
              questionIndex: index + 1,
              answerMap: widget.answerMap,
              pageController: _pageController,
              question: question,
            )*/
          ],
        );
      },
    );
  }
}
