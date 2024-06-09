import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/domain/model/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/style_manager.dart';
import '../../../../domain/model/question.dart';
import 'answer_bar.dart';

class AnswerPreviewBar extends StatelessWidget {
  const AnswerPreviewBar(
      {super.key,
      required this.questionText,
      required this.questionIndex,
      required this.answer,
      this.selectedAnswer,
      required this.answerMap});
  final Map<int, String> answerMap;
  final String questionText;
  final int questionIndex;
  final Answer answer;
  final String? selectedAnswer;

  Color getCorrectLetter(String letter) {
    Color returnColor = ColorManager.defaultChoiceColor;
    String? selectedLetter = answerMap[questionIndex]?[0];
    String correctLetter = answerLetter[answer.correctAnswer];
    if (selectedLetter != null &&
        selectedLetter == letter &&
        selectedLetter != correctLetter) {
      returnColor = ColorManager.errorColor;
    }
    if (letter == correctLetter) {
      returnColor = ColorManager.correctChoiceColor;
    }
    return returnColor;
  }

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
        IgnorePointer(
          ignoring: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int i = 0; i < answer.answers.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: getCorrectLetter(answerLetter[i]),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(answerLetter[i],
                                  style: getSemiBoldStyle(
                                      color: Colors.limeAccent, fontSize: 14)),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Text(
                            answer.answers[i],
                            style: getRegularStyle(color: Colors.black)
                                .copyWith(overflow: TextOverflow.clip),
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
              ],
            ),
          ),
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
