import 'package:ez_english/domain/model/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExplanationBottomSheet extends StatelessWidget {
  List<Answer> answerList;

  ExplanationBottomSheet(this.answerList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: answerList.length, // Number of tabs
      child: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 0.7,
        child: Column(
          children: <Widget>[
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                for (int i = 1; i <= answerList.length; i++)
                  Tab(
                    text: "${AppLocalizations.of(context)!.question} $i",
                  )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ...answerList.map(
                    (e) => SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: Text(e.explanation ??
                          AppLocalizations.of(context)!.not_update_yet),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
