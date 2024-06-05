import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpeakingResultPage extends StatelessWidget {
  final List<bool> isCorrectList;
  final int part;

  const SpeakingResultPage({required this.isCorrectList, required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GradientAppBar(
            content: '',
            prefixIcon: InkWell(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context, RoutesName.skillPracticeRoute, 
                  arguments: 'Speaking'
                );
              }
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < isCorrectList.length; i++)
                    SpeakingResultItem(isCorrectList[i], i + 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpeakingResultItem extends StatelessWidget {
  final bool isCorrect;
  final int questionNumber;

  const SpeakingResultItem(this.isCorrect, this.questionNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Text(
            '${AppLocalizations.of(context)!.question} $questionNumber',
            style: getRegularStyle(color: Colors.black, fontSize: 14)
          ),
          const SizedBox(width: 8),
          isCorrect ? 
            const Icon(
              Icons.check,
              color: Colors.green, 
              size: 20,      
            ) :
            const Icon(
              Icons.close,
              color: Colors.red,
              size: 20,
            ),
        ],
      ),
    );
  }
}