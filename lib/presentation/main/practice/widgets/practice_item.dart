import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../config/constants.dart';
import '../../../../utils/route_manager.dart';
import '../../../common/widgets/stateless/common_button.dart';

class PracticeItem extends StatelessWidget {
  final int index;
  final String title;
  final String imagePath;

  const PracticeItem(this.index, this.title, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    String trainNote = AppLocalizations.of(context)!.train_your +
        title +
        AppLocalizations.of(context)!.skill_by_our_tests;

    return Column(children: <Widget>[
      Image.asset(
        imagePath,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        title,
        style: getSemiBoldStyle(
            color: ColorManager.primaryTextColor, fontSize: 24),
      ),
      const SizedBox(
        height: 9,
      ),
      Text(trainNote,
          style: getRegularStyle(
              color: ColorManager.lightTextColor, fontSize: 14)),
      const SizedBox(
        height: 20,
      ),
      FractionallySizedBox(
        widthFactor: 0.8,
        child: CommonButton(
          text: AppLocalizations.of(context)!.start,
          action: () {
            Navigator.pushNamed(context, RoutesName.skillPracticeRoute,
                arguments: skillList[index]);
          },
        ),
      ),
    ]);
  }
}