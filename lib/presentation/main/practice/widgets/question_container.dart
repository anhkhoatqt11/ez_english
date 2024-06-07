import 'package:ez_english/domain/model/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/style_manager.dart';
import '../../../../domain/model/question.dart';
import 'answer_bar.dart';

class QuestionContainer extends StatelessWidget {
  const QuestionContainer(
      {super.key,
      required this.questionText,
      required this.questionIndex,
      required this.onAnswerSelected,
      required this.answer,
      this.selectedAnswer , this.isTest});
  final String questionText;
  final int questionIndex;
  final ValueChanged<String> onAnswerSelected;
  final Answer answer;
  final String? selectedAnswer;
  final bool? isTest;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              style: getSemiBoldStyle(color: Colors.black, fontSize: 16),
              children: [
                TextSpan(
                    text:
                        "${AppLocalizations.of(context)!.question} $questionIndex : "),
                TextSpan(
                  text: questionText,
                )
              ]),
          maxLines: 100,
        ),
        AnswerBar(
          isTest: isTest,
          onAnswerSelected: onAnswerSelected,
          answer: answer,
          selectedAnswer: selectedAnswer,
          questionIndex: questionIndex,
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 4,
          endIndent: 4,
        )
      ],
    );
  }
}
