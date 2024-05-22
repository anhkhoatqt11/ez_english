import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/functions.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/result/widgets/result_item.dart';
import 'package:ez_english/presentation/result/widgets/result_list_view_item.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.answerMap, required this.part});
  final Map<int, String> answerMap;
  final PartObject part;
  @override
  _ResultPageState createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<ResultPage> {
  int numOfCorrect = 0;
  int numOfQuestion = 1;
  Map<int, String> errorMap = {};
  @override
  void initState() {
    super.initState();
    numOfQuestion = widget.answerMap.length;
    widget.answerMap.forEach(
      (key, value) {
        if (value[0] == value[2]) {
          numOfCorrect++;
        } else {
          errorMap[key] = value;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getPercentString(int a, int b) {
    double c = a / b * 100;
    return "${c.toStringAsFixed(2)}%";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                              "${AppLocalizations.of(context)!.complete_practice}\n",
                          style: getMediumStyle(
                              color: Colors.black, fontSize: 18)),
                      TextSpan(
                          text:
                              "${widget.part.title}\n${getTranslatedSkill(widget.part.skill, context)}\n",
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
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${AppLocalizations.of(context)!.result}: $numOfCorrect/$numOfQuestion",
                style: getMediumStyle(color: Colors.black, fontSize: 18),
              ),
              ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 50,
                  height: 50,
                  child: Center(
                      child: Text(
                    getPercentString(numOfCorrect, numOfQuestion),
                    style: getMediumStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
              )
            ],
          )),
          ResultItem(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.error_list,
                style: getSemiBoldStyle(color: Colors.orange, fontSize: 18),
              ),
              ListView.builder(
                itemCount: numOfQuestion % 10,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => const ResultListViewItem(),
              ),
              Center(
                child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.see_all_answers)),
              ),
            ],
          )),
          const SizedBox(
            height: 18,
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.7)),
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.app_continue),
          ),
          const SizedBox(
            height: 18,
          )
        ],
      ),
    ));
  }
}
