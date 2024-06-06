import 'package:ez_english/domain/model/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/style_manager.dart';
import '../../../../utils/route_manager.dart';

class TestItem extends StatelessWidget {
  const TestItem({super.key, required this.testItem});
  final Test testItem;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutesName.testInformation, arguments: testItem);
      },
      child: Card(
        surfaceTintColor: Colors.white70,
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(14),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(testItem.name),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${AppLocalizations.of(context)!.num_of_questions}: ',
                    style: getLightStyle(color: Colors.black)),
                TextSpan(
                    text: testItem.numOfQuestions.toString(),
                    style: getRegularStyle(color: ColorManager.errorColor)),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${AppLocalizations.of(context)!.minutes}: ',
                    style: getLightStyle(color: Colors.black)),
                TextSpan(
                    text: testItem.time.toString(),
                    style: getRegularStyle(color: ColorManager.errorColor)),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
