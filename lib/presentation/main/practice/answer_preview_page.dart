import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/presentation/blocs/questions_by_part/questions_by_part_bloc.dart';
import 'package:ez_english/presentation/common/objects/get_questions_by_part_object.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/answer_bar.dart';
import 'package:ez_english/presentation/main/practice/widgets/answer_preview_bar.dart';
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

class AnswerPreviewPage extends StatefulWidget {
  const AnswerPreviewPage(
      {super.key,
      required this.questionList,
      required this.part,
      required this.answerMap});
  final List<Question> questionList;
  final PartObject part;
  final Map<int, String> answerMap;
  @override
  State<AnswerPreviewPage> createState() => _AnswerPreviewPageState();
}

class _AnswerPreviewPageState extends State<AnswerPreviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        GradientAppBar(
          content: widget.part.title,
          suffixIcon: InkWell(
            onTap: () {
              Navigator.popUntil(
                context,
                (route) => route.settings.name == RoutesName.mainRoute,
              );
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
        Expanded(
            child: AnswerPreviewBody(
          questionList: widget.questionList,
          answerMap: widget.answerMap,
        )),
      ]),
    );
  }
}

class AnswerPreviewBody extends StatefulWidget {
  AnswerPreviewBody(
      {super.key, required this.questionList, required this.answerMap});
  List<Question> questionList;
  Map<int, String> answerMap;
  @override
  _AnswerPreviewBodyState createState() => _AnswerPreviewBodyState();
}

class _AnswerPreviewBodyState extends State<AnswerPreviewBody> {
  final PageController _pageController = PageController();
  final appPrefs = GetIt.instance<AppPrefs>();
  late bool isHorizontal;
  Map<int, String> _answers = {};
  @override
  void initState() {
    // TODO: implement initState
    _answers = widget.answerMap;
    super.initState();
    isHorizontal = appPrefs.getHorizontalAnswerBarLayout() ?? false;
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
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
                        showExplanation(question.answers, context);
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
                                    entry.key + questionStartIndex + 1;
                                String questionText = entry.value;
                                String? selectedAnswer =
                                    _answers[questionIndex];
                                print(questionIndex);
                                return AnswerPreviewBar(
                                  answerMap: widget.answerMap,
                                  answer: question.answers[entry.key],
                                  questionText: questionText,
                                  selectedAnswer: selectedAnswer,
                                  questionIndex: questionIndex,
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
