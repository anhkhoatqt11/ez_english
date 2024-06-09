import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultListViewItem extends StatelessWidget {
  const ResultListViewItem(
      {super.key, required this.questionIndex, required this.correctAnswer});
  final int questionIndex;
  final String correctAnswer;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("${AppLocalizations.of(context)!.question}: $questionIndex"),
          Text(
              "${AppLocalizations.of(context)!.correct_answer}: $correctAnswer"),
          //Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
