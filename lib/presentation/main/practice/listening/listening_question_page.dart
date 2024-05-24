import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/presentation/common/objects/get_questions_by_part_object.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/answer_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/horizontal_answer_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/question_container.dart';
import 'package:ez_english/presentation/main/practice/widgets/time_counter.dart';
import 'package:ez_english/presentation/main/practice/widgets/track_bar.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../config/functions.dart';
import '../../../../domain/model/question.dart';
import '../../../blocs/questions_by_part/questions_by_part_bloc.dart';

class ListeningQuestionPage extends StatefulWidget {
  const ListeningQuestionPage(
      {super.key, required this.part, required this.timeLimit});
  final PartObject part;
  final Duration timeLimit;
  @override
  State<ListeningQuestionPage> createState() => _ListeningQuestionPageState();
}

class _ListeningQuestionPageState extends State<ListeningQuestionPage> {
  Map<int, String> answerMap = {};

  QuestionsByPartBloc questionsByPartBloc =
      GetIt.instance<QuestionsByPartBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionsByPartBloc.add(LoadQuestions(
        GetQuestionsByPartObject(widget.part.index, "Listening")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        GradientAppBar(
          content: widget.part.title,
          suffixIcon: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.resultPracticeRoute,
                  arguments: [answerMap, widget.part]);
            },
            child: Text(
              AppLocalizations.of(context)!.submit,
              style: getMediumStyle(color: Colors.white).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2),
            ),
          ),
          prefixIcon: InkWell(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
        ),
        (widget.timeLimit.inSeconds > 0)
            ? TimeCounter(timeLimit: widget.timeLimit)
            : Container(),
        Expanded(
          child: BlocBuilder<QuestionsByPartBloc, QuestionsByPartState>(
            bloc: questionsByPartBloc,
            builder: (context, state) {
              if (state is QuestionsByPartLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is QuestionsByPartErrorState) {
                return Center(
                  child: Text(state.failure.toString()),
                );
              }
              if (state is QuestionsByPartSuccessState) {
                return ListeningQuestionPageBody(
                  answerMap: answerMap,
                  questionList: state.questionList,
                );
              }
              return Container();
            },
          ),
        ),
      ]),
    );
  }
}

class ListeningQuestionPageBody extends StatefulWidget {
  ListeningQuestionPageBody(
      {super.key, required this.answerMap, required this.questionList});
  Map<int, String> answerMap;
  List<Question> questionList;
  @override
  _ListeningQuestionPageBodyState createState() =>
      _ListeningQuestionPageBodyState();
}

class _ListeningQuestionPageBodyState extends State<ListeningQuestionPageBody>
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
    super.dispose();
  }

  Future<void> _checkCurrentPageAnswers() async {
    print("I'm checking !");
    int currentIndex = _pageController.page!.round();
    List<String?> currentPageAnswers = widget
        .questionList[currentIndex].questions
        .asMap()
        .entries
        .map((entry) =>
            _answers[entry.key + _getQuestionStartIndex(currentIndex)])
        .toList();
    if (currentPageAnswers.every((answer) => answer != null)) {
      if (currentIndex < widget.questionList.length - 1) {
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
      startIndex += widget.questionList[i].questions.length;
    }
    return startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questionList.length,
      itemBuilder: (context, index) {
        Question question = widget.questionList[index];
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
                        showExplanation(
                            question.answers.first.explanation ??
                                AppLocalizations.of(context)!.not_update_yet,
                            context);
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
                              children: question.questions
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int questionIndex =
                                    entry.key + questionStartIndex;
                                String questionText = entry.value;
                                String? selectedAnswer =
                                    _answers[questionIndex];
                                return QuestionContainer(
                                  answer: question.answers[entry.key],
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
            /*isHorizontal
                ? HorizontalAnswerBar(
                    questionIndex: index + 1,
                    answerMap: widget.answerMap,
                    pageController: _pageController,
                    question: question)
                : Container()*/
          ],
        );
      },
    );
  }
}
