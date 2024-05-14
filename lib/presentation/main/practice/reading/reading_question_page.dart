import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/presentation/common/objects/get_questions_by_part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/answer_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/time_counter.dart';
import 'package:ez_english/presentation/main/practice/widgets/track_bar.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/model/question.dart';
import '../../../blocs/questions_by_part/questions_by_part_bloc.dart';

class ReadingQuestionPage extends StatefulWidget {
  const ReadingQuestionPage({super.key, required this.part});
  final int part;
  @override
  State<ReadingQuestionPage> createState() => _ReadingQuestionPageState();
}

class _ReadingQuestionPageState extends State<ReadingQuestionPage> {
  Map<int, String> answerMap = {};

  QuestionsByPartBloc questionsByPartBloc =
      GetIt.instance<QuestionsByPartBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionsByPartBloc
        .add(LoadQuestions(GetQuestionsByPartObject(widget.part, "Reading")));
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
                  child: ReadingQuestionPageBody(
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

class ReadingQuestionPageBody extends StatefulWidget {
  ReadingQuestionPageBody(
      {super.key, required this.answerMap, required this.questionList});
  Map<int, String> answerMap;
  List<Question> questionList;
  @override
  _ReadingQuestionPageBodyState createState() =>
      _ReadingQuestionPageBodyState();
}

class _ReadingQuestionPageBodyState extends State<ReadingQuestionPageBody> {
  final PageController _pageController = PageController();

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
        });
  }

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
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: AnswerBar(
                  question: question,
                  questionIndex: index + 1,
                  answerMap: widget.answerMap,
                  pageController: _pageController),
            ),
            const SizedBox(
              height: 32,
            ),
            FilledButton(
                onPressed: () {
                  showExplanation(question.explanation ??
                      AppLocalizations.of(context)!.not_update_yet);
                },
                child: Text(AppLocalizations.of(context)!.explanation))
          ],
        );
      },
    );
  }
}
