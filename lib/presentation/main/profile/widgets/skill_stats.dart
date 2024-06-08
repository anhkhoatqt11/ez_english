import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkillSlider extends StatelessWidget {
  final String skillName;
  final int skillValue;

  SkillSlider({required this.skillName, required this.skillValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skillName,
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  gradient: ColorManager.linearGradientPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Slider(
                value: skillValue.toDouble(),
                min: 0,
                max: 1000,
                divisions: 1000,
                label: '$skillValue Points',
                onChanged: (value) {},
                activeColor: ColorManager.activityColor,
                inactiveColor: Colors.transparent,
              ),
              Positioned(
                left: 160,
                child: Icon(Icons.flag,
                    color: skillValue >= 500
                        ? ColorManager.secondaryColor
                        : Colors.transparent),
              ),
              Positioned(
                right: 0,
                child: Icon(Icons.flag,
                    color: skillValue >= 1000
                        ? ColorManager.secondaryColor
                        : Colors.transparent),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: getRegularStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                '500',
                style: getRegularStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                '1000',
                style: getRegularStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserStats extends StatelessWidget {
  final int listening;
  final int reading;
  final int writing;
  final int speaking;

  UserStats({
    required this.listening,
    required this.reading,
    required this.writing,
    required this.speaking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.progress_title,
                    style: getSemiBoldStyle(color: Colors.black, fontSize: 16)),
                Text(AppLocalizations.of(context)!.progress_subtitle,
                    style: getLightStyle(color: Colors.black, fontSize: 12)),
              ],
            )),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkillSlider(skillName: 'Listening', skillValue: listening),
              SkillSlider(skillName: 'Reading', skillValue: reading),
              SkillSlider(skillName: 'Writing', skillValue: writing),
              SkillSlider(skillName: 'Speaking', skillValue: speaking),
            ],
          ),
        ),
      ],
    );
  }
}
