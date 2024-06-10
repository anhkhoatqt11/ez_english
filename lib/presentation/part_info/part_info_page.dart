import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ez_english/config/functions.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/objects/mutable_variable.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateful/common_dropdown_button.dart';
import 'package:ez_english/presentation/common/widgets/stateful/common_switch.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PartInfoPage extends StatefulWidget {
  PartInfoPage(
      {super.key,
      required this.isPractice,
      required this.partObject,
      this.nextButton});
  final bool isPractice;
  final PartObject partObject;
  Widget? nextButton;

  @override
  State<PartInfoPage> createState() => _PartInfoPageState();
}

class _PartInfoPageState extends State<PartInfoPage> {
  int numOfQuestion = 5;

  bool isTest = false;

  Duration timeLimit = Duration.zero;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: [
        widget.isPractice
            ? GradientAppBar(
                content: widget.partObject.title,
                prefixIcon: InkWell(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.partObject.title,
                    style: getBoldStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.question,
                  style: getSemiBoldStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  getPartIntroduction(
                      widget.partObject.index, widget.partObject.skill),
                  style: getRegularStyle(color: Colors.black),
                  maxLines: 100,
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        widget.isPractice
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 100,
                      child: Text(
                        "${AppLocalizations.of(context)!.num_of_questions}: ",
                        maxLines: 2,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        items: [
                          ...List.generate(
                            25,
                            (index) => index + 5,
                          ).map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ),
                          )
                        ],
                        value: numOfQuestion,
                        onChanged: (dynamic value) {
                          if (value != null) {
                            setState(() {
                              numOfQuestion = value;
                            });
                          }
                        },
                        buttonStyleData: const ButtonStyleData(
                            height: 30,
                            width: 60,
                            padding: EdgeInsets.only(left: 8)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text("${AppLocalizations.of(context)!.test_mode}: "),
                  Switch(
                    value: isTest,
                    onChanged: (value) {
                      setState(() {
                        isTest = value;
                      });
                    },
                  )
                ],
              )
            : Container(),
        isTest
            ? Builder(builder: (context) {
                timeLimit = Duration(
                    seconds:
                        getSecondEachQuestion(skill: widget.partObject.skill) *
                            numOfQuestion);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(formatDuration(timeLimit))
                    ],
                  ),
                );
              })
            : Container(),
        !widget.isPractice
            ? widget.nextButton ?? Container()
            : FilledButton(
                onPressed: () {
                  navigateToQuestionPage();
                },
                child: Text(AppLocalizations.of(context)!.start_now))
      ],
    ));
  }

  void navigateToQuestionPage() {
    switch (widget.partObject.skill) {
      case "Listening":
        Navigator.pushNamed(context, RoutesName.listeningQuestionRoute,
            arguments: [widget.partObject, timeLimit, numOfQuestion]);
      case "Reading":
        Navigator.pushNamed(context, RoutesName.readingQuestionRoute,
            arguments: [widget.partObject, timeLimit, numOfQuestion]);
      case "Speaking":
        Navigator.pushNamed(context, RoutesName.speakingQuestionRoute,
            arguments: [widget.partObject, timeLimit, numOfQuestion]);
      case "Writing":
        Navigator.pushNamed(context, RoutesName.writingQuestionRoute,
            arguments: [widget.partObject, numOfQuestion]);
      default:
        return;
    }
  }
}
