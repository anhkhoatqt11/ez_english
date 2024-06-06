import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpeakingResultPage extends StatelessWidget {
  final List<Map<bool, String>> isCorrectList;
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
                    SpeakingResultItem(
                      isCorrectList[i].keys.first,
                      isCorrectList[i].values.first,
                      i + 1
                    ),
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
  final bool _isCorrect;
  final String _lastWords;
  final int _questionNumber;

  const SpeakingResultItem(this._isCorrect, this._lastWords, this._questionNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: <Widget>[
          _isCorrect ? 
            const Icon(
              Icons.check,
              color: Colors.green, 
              size: 25,      
            ) :
            const Icon(
              Icons.close,
              color: Colors.red,
              size: 25,
            ),
          const SizedBox(width: 8),
          Text(
            '${AppLocalizations.of(context)!.question} $_questionNumber',
            style: getRegularStyle(color: Colors.black, fontSize: 18)
          ),
          const SizedBox(width: 20),
          Text(
            _lastWords,
            style: getRegularStyle(color: Colors.black, fontSize: 18),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}