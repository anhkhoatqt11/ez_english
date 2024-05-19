import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/domain/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../app_prefs.dart';

class HorizontalAnswerBar extends StatefulWidget {
  final int questionIndex;
  Map<int, String> answerMap;
  HorizontalAnswerBar(
      {super.key,
      required this.questionIndex,
      required this.answerMap,
      required this.pageController,
      required this.question});
  final PageController pageController;
  final Question question;
  @override
  _HorizontalAnswerBarState createState() => _HorizontalAnswerBarState();
}

class _HorizontalAnswerBarState extends State<HorizontalAnswerBar> {
  Future<void> chooseAnswer(String letter) async {
    setState(() {
      widget.answerMap[widget.questionIndex] = letter;
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
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorManager.darkSlateGrayColor,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 0.5,
                  offset: Offset.zero)
            ],
            color: ColorManager.secondaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...widget.question.choices.map(
              (i) => Container(
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
                    chooseAnswer(i.letter);
                  },
                  child: Text(i.letter,
                      style: getSemiBoldStyle(
                          color: setBorderAndTextChoice(i.letter),
                          fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}