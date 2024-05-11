import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/presentation/common/objects/get_questions_by_part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/time_counter.dart';
import 'package:ez_english/presentation/main/practice/widgets/track_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/model/question.dart';
import '../../blocs/questions_by_part/questions_by_part_bloc.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.skill, required this.part});
  final String skill;
  final int part;
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Map<int, String> answerMap = {};

  QuestionsByPartBloc questionsByPartBloc =
      GetIt.instance<QuestionsByPartBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionsByPartBloc.add(
        LoadQuestions(GetQuestionsByPartObject(widget.part, widget.skill)));
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context);
              }),
        ),
        const TimeCounter(timeLimit: Duration(minutes: 3)),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListeningQuestionPageBody(
                    answerMap: answerMap,
                    questionList: state.questionList,
                  ),
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

class _ListeningQuestionPageBodyState extends State<ListeningQuestionPageBody> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.questionList.length,
      itemBuilder: (context, index) {
        Question question = widget.questionList[index];
        return ListView(
          children: <Widget>[
            Text(
              question.title ?? '',
              maxLines: 100,
              style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
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
            question.audioUrl != null ? TrackBar() : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: AnswerBar(
                  choiceList: question.choices,
                  questionIndex: index + 1,
                  answerMap: widget.answerMap,
                  pageController: _pageController),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        );
      },
    );
  }
}

class AnswerBar extends StatefulWidget {
  final int questionIndex;
  Map<int, String> answerMap;
  AnswerBar(
      {super.key,
      required this.questionIndex,
      required this.answerMap,
      required this.pageController,
      required this.choiceList});
  final PageController pageController;
  final List<Choice> choiceList;
  @override
  _AnswerBarState createState() => _AnswerBarState();
}

class _AnswerBarState extends State<AnswerBar> {
  void chooseAnswer(String letter) {
    setState(() {
      widget.answerMap[widget.questionIndex] = letter;
    });
    widget.pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            '${AppLocalizations.of(context)!.question} ${widget.questionIndex}',
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14)),
        const SizedBox(
          height: 8,
        ),
        ...widget.choiceList.map((i) => Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: (widget.answerMap[widget.questionIndex] ?? '') ==
                                i.letter
                            ? ColorManager.primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color:
                              (widget.answerMap[widget.questionIndex] ?? '') ==
                                      i.letter
                                  ? ColorManager.primaryColor
                                  : Colors.black,
                          width: 1,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          chooseAnswer(i.letter);
                        },
                        child: Text(i.letter,
                            style: getSemiBoldStyle(
                                color:
                                    (widget.answerMap[widget.questionIndex] ??
                                                '') ==
                                            i.letter
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 14)),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Text(
                      i.content ?? i.letter,
                      style: getRegularStyle(color: Colors.black)
                          .copyWith(overflow: TextOverflow.clip),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )),
      ],
    );
  }
}
