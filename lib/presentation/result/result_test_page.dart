import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/functions.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/usecase/save_in_history_usecase.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/presentation/common/objects/history_object.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/result/widgets/result_item.dart';
import 'package:ez_english/presentation/result/widgets/result_list_view_item.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ResultTestPage extends StatefulWidget {
  const ResultTestPage(
      {super.key,
      required this.answerMap,
      required this.skills,
      required this.testItem});
  final Map<int, String> answerMap;
  final List<String?> skills;
  final Test testItem;
  @override
  _ResultTestPageState createState() {
    return _ResultTestPageState();
  }
}

class _ResultTestPageState extends State<ResultTestPage> {
  int numOfSkill1Correct = 0;
  int numOfSkill2Correct = 0;
  Map<String, int> resultMap = {};
  @override
  void initState() {
    super.initState();

    widget.answerMap.forEach(
      (key, value) {
        if (value[0] == value[2]) {
          if (key <= widget.testItem.numOfQuestions / 2) {
            numOfSkill1Correct++;
          } else {
            numOfSkill2Correct++;
          }
        }
      },
    );
    resultMap = calculateToeicScore(
        widget.skills, numOfSkill1Correct, numOfSkill2Correct);
    Test i = widget.testItem;
    GetIt.instance<SaveInHistoryUseCase>().execute(HistoryObject(DateTime.now(),
        i.id, resultMap["Total"] as int, true, supabase.auth.currentUser!.id));
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: canPop,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar(
              content: AppLocalizations.of(context)!.result,
            ),
            ResultItem(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipOval(
                  child: Image.asset(
                    ImagePath.logoPath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.complete_test} \n",
                            style: getMediumStyle(
                                color: Colors.black, fontSize: 18)),
                        TextSpan(
                            text: "${widget.testItem.name} \n",
                            style: getMediumStyle(
                                color: Colors.orange, fontSize: 18)),
                        TextSpan(
                            text: AppLocalizations.of(context)!.good_luck,
                            style: getRegularStyle(
                                color: Colors.black, fontSize: 16)),
                      ])),
                )
              ],
            )),
            ResultItem(
                child: Column(
              children: [
                ...resultMap.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${e.key} ${AppLocalizations.of(context)!.result}: ",
                          style:
                              getMediumStyle(color: Colors.black, fontSize: 18),
                        ),
                        ClipOval(
                          child: Container(
                            color: Colors.red,
                            width: 60,
                            height: 60,
                            child: Center(
                                child: Text(
                              "${e.value}",
                              style: getMediumStyle(
                                  color: Colors.white, fontSize: 16),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
            ResultItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: FilledButton(
                        onPressed: () {
                          canPop = true;
                          Navigator.pop(context, true);
                        },
                        child: Text(
                            AppLocalizations.of(context)!.see_all_answers)),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.mainRoute,
                        (route) => route.settings.name != RoutesName.mainRoute,
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.app_continue),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      )),
    );
  }
}
