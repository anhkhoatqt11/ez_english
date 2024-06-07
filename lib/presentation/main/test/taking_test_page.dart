import 'dart:async';

import 'package:ez_english/config/functions.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/test/test_question_page.dart';
import 'package:ez_english/presentation/main/test/widgets/test_inherited_widget.dart';
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
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int second = 0;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (pagePartController.page != null &&
          pagePartController.page!.toInt() == pagePartController.page) {
        print("Second ${timer.tick}");
      }
      timer.cancel();
    });
  }

  List<PartObject> partList = [];
  PageController pagePartController = PageController();
  List<int> itemList = List.generate(5, (index) => index, growable: true);
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    partList = getPartByTest(widget.skills, context);
    // TODO: implement build
    return Scaffold(
      body: Column(children: <Widget>[
        GradientAppBar(
          content: "Taking test",
          suffixIcon: InkWell(
            onTap: () {},
            child: Text(
              AppLocalizations.of(context)!.submit,
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
        ),
        /*(widget.timeLimit.inSeconds > 0)
            ? TimeCounter(timeLimit: widget.timeLimit)
            : Container(),*/
        Expanded(
          child: PageView.builder(
              controller: pagePartController,
              itemCount: partList.length,
              itemBuilder: (context, index) {
                return TestQuestionPage(
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
