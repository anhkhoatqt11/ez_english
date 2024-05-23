import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/config/functions.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/domain/model/answer.dart';
import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/domain/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class AnswerBar extends StatefulWidget {
  final int questionIndex;
  Map<int, String> answerMap;
  AnswerBar(
      {super.key,
      required this.questionIndex,
      required this.answerMap,
      required this.pageController,
      required this.answer});
  final PageController pageController;
  final Answer answer;
  @override
  _AnswerBarState createState() => _AnswerBarState();
}

class _AnswerBarState extends State<AnswerBar> {
  Future<void> chooseAnswer(String letter, String correctLetter) async {
    setState(() {
      widget.answerMap[widget.questionIndex] = "$letter:$correctLetter";
    });
    if (GetIt.instance<AppPrefs>().getAutoChangeQuestion() ?? true) {
      await Future.delayed(const Duration(seconds: 1));
      widget.pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    }
  }

  Color setChoiceColor(String letter) {
    Color returnColor = ColorManager.defaultChoiceColor;
    if (widget.answerMap[widget.questionIndex] != null) {
      String selectedLetter = widget.answerMap[widget.questionIndex]!;
      String correctLetter = answerLetter[widget.answer.correctAnswer];
      if (letter == correctLetter) {
        returnColor = ColorManager.errorColor;
      }
      if (letter == selectedLetter) {
        returnColor = ColorManager.primaryColor;
      }
      if (selectedLetter == correctLetter &&
          letter == selectedLetter) {
        returnColor = ColorManager.correctChoiceColor;
      }
    }
    return returnColor;
  }

  Color setBorderAndTextChoice(String letter) {
    if (widget.answerMap[widget.questionIndex] != null) {
      String selectedLetter = widget.answerMap[widget.questionIndex]!;
      String correctLetter = answerLetter[widget.answer.correctAnswer];
      if (selectedLetter == letter || letter == correctLetter) {
        return Colors.white;
      }
    }
    return Colors.black;
  }


  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.answerMap[widget.questionIndex] != null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < widget.answer.answers.length; i++)
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: setChoiceColor(answerLetter[i]),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: setBorderAndTextChoice(answerLetter[i]),
                            width: 1,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            chooseAnswer(answerLetter[i],
                                answerLetter[widget.answer.correctAnswer]);
                          },
                          child: Text(answerLetter[i],
                              style: getSemiBoldStyle(
                                  color: setBorderAndTextChoice(answerLetter[i]),
                                  fontSize: 14)),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                            widget.answer.answers[i],
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
    );
  }
}
