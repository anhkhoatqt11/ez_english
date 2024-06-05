import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/domain/model/answer.dart';
import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/domain/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../app_prefs.dart';
import '../../../../config/constants.dart';

/*class HorizontalAnswerBar extends StatefulWidget {
  final int questionStartIndex;
  const HorizontalAnswerBar(
      {super.key,
      required this.questionStartIndex,
      required this.onAnswerSelected,
      required this.question});
  final ValueChanged<int,String> onAnswerSelected;
  final Question question;

  @override
  _HorizontalAnswerBarState createState() => _HorizontalAnswerBarState();
}

class _HorizontalAnswerBarState extends State<HorizontalAnswerBar> {
  late Map<int, String> _answers;
  String? selectedLetter;
  late Answer answer;
  late Question question;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answer = widget.question.answers.first;
    question = widget.question;
    _answers = widget.answers;
  }

  Color setChoiceColor(String letter) {
    Color returnColor = ColorManager.defaultChoiceColor;
    if (selectedLetter != null) {
      String correctLetter = answerLetter[answer.correctAnswer];
      if (letter == correctLetter) {
        returnColor = ColorManager.errorColor;
      }
      if (letter == selectedLetter) {
        returnColor = ColorManager.primaryColor;
      }
      if (selectedLetter == correctLetter && letter == selectedLetter) {
        returnColor = ColorManager.correctChoiceColor;
      }
    }
    return returnColor;
  }

  Color setBorderAndTextChoice(String letter) {
    if (selectedLetter != null) {
      String correctLetter = answerLetter[answer.correctAnswer];
      if (selectedLetter == letter || letter == correctLetter) {
        return Colors.white;
      }
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: DefaultTabController(
        length: question.questions.length,
        child: Builder(builder: (context) {
          int i = 1;
          return Column(
            children: [
              TabBar(
                  onTap: (value) {
                    setState(() {
                      answer = question.answers[value];
                    });
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: widget.question.questions
                      .map(
                        (e) => Text("${i++}"),
                      )
                      .toList()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: answer.answers.asMap().entries.map((e) {
                      int questionIndex = e.key + widget.questionStartIndex;
                      String? selectedAnswer = _answers[questionIndex];
                      return Container(
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
                            setState(() {
                              setState(() {
                                widget.onAnswerSelected.call(answerLetter[i]);
                                selectedLetter = answerLetter[i];
                              });
                            });
                          },
                          child: Text(answerLetter[i],
                              style: getSemiBoldStyle(
                                  color:
                                      setBorderAndTextChoice(answerLetter[i]),
                                  fontSize: 14)),
                        ),
                      );
                    }).toList()),
              )
            ],
          );
        }),
      ),
    );
  }
}*/
