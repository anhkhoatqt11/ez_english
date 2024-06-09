import 'dart:async';

import 'package:ez_english/config/functions.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/test/test_question_page.dart';
import 'package:ez_english/presentation/main/test/widgets/test_inherited_widget.dart';
import 'package:ez_english/presentation/main/test/widgets/test_time_counter.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/style_manager.dart';

class TakingTestPage extends StatefulWidget {
  const TakingTestPage(
      {super.key, required this.testItem, required this.skills});
  final Test testItem;
  final List<String?> skills;
  @override
  _TakingTestPageState createState() {
    return _TakingTestPageState();
  }
}

class _TakingTestPageState extends State<TakingTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map<int, String> answerMap = {};
  int second = 0;

  List<PartObject> partList = [];
  PageController pagePartController = PageController();
  List<int> itemList = List.generate(5, (index) => index, growable: true);
  Timer? timer;
  bool isReview = false;
  @override
  Widget build(BuildContext context) {
    partList = getPartByTest(widget.skills, context);
    print("FSDFSDFDSFSDFSFSDFSD");
    // TODO: implement build
    return Scaffold(
      body: Column(children: <Widget>[
        GradientAppBar(
          suffixIcon: InkWell(
            onTap: () async {
              bool isReview = await Navigator.pushNamed(
                      context, RoutesName.resultTestRoute,
                      arguments: [answerMap, widget.skills, widget.testItem]) ??
                  false;
            },
            child: Text(
              !isReview
                  ? AppLocalizations.of(context)!.submit
                  : AppLocalizations.of(context)!.return_home,
              style: getMediumStyle(color: Colors.white).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2),
            ),
          ),
          prefixIcon: InkWell(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          content: '',
        ),
        TestTimeCounter(
          timeLimit: Duration(minutes: widget.testItem.time),
          navigateToNextPage: () async {
            bool isReview = await Navigator.pushNamed(
                    context, RoutesName.resultTestRoute,
                    arguments: [answerMap, widget.skills, widget.testItem]) ??
                false;
          },
        ),
        Expanded(
          child: PageView.builder(
              controller: pagePartController,
              itemCount: partList.length,
              itemBuilder: (context, index) {
                return TestQuestionPage(
                  answerMap: answerMap,
                  pagePartController: pagePartController,
                  part: partList[index],
                  test: widget.testItem,
                );
              }),
        ),
      ]),
    );
  }
}
