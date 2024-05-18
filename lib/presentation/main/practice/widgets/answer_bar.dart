import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
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
      required this.question});
  final PageController pageController;
  final Question question;
  @override
  _AnswerBarState createState() => _AnswerBarState();
}

class _AnswerBarState extends State<AnswerBar> {
  Future<void> chooseAnswer(String letter , String correctLetter) async {
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
      if (letter == widget.question.correctLetter) {
        returnColor = ColorManager.errorColor;
      }
      if (letter == selectedLetter) {
        returnColor = ColorManager.primaryColor;
      }
      if (selectedLetter == widget.question.correctLetter &&
          letter == selectedLetter) {
        returnColor = ColorManager.correctChoiceColor;
      }
    }
    return returnColor;
  }

  Color setBorderAndTextChoice(String letter) {
    if (widget.answerMap[widget.questionIndex] != null) {
      String selectedLetter = widget.answerMap[widget.questionIndex]!;
      if (selectedLetter == letter || letter == widget.question.correctLetter) {
        return Colors.white;
      }
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.answerMap[widget.questionIndex] != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...widget.question.choices.map((i) => Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: setChoiceColor(i.letter),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: setBorderAndTextChoice(i.letter),
                            width: 1,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            chooseAnswer(i.letter , widget.question.correctLetter ?? i.letter);
                          },
                          child: Text(i.letter,
                              style: getSemiBoldStyle(
                                  color: setBorderAndTextChoice(i.letter),
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
      ),
    );
  }
}
