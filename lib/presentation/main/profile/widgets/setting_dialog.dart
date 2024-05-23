import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/presentation/main/profile/widgets/audio_rate_drop_down.dart';
import 'package:ez_english/presentation/main/profile/widgets/audio_volume_drop_down.dart';
import 'package:ez_english/presentation/main/profile/widgets/setting_item.dart';
import 'package:ez_english/presentation/main/profile/widgets/setting_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: Center(
                  child: Text(AppLocalizations.of(context)!.display),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.highlight_remove_rounded,
                    color: ColorManager.whiteColor,
                  ),
                ),
              )
            ],
          ),
          SettingItem(
              prefixIcon: const Icon(Icons.skip_next),
              content: AppLocalizations.of(context)!.auto_next,
              suffixWidget: SettingSwitch(
                isTrue:
                    GetIt.instance<AppPrefs>().getAutoChangeQuestion() ?? true,
              )),
          SettingItem(
              prefixIcon: const Icon(Icons.volume_up),
              content: AppLocalizations.of(context)!.audio_volume,
              suffixWidget: AudioVolumeDropDown()),
          SettingItem(
              prefixIcon: const Icon(Icons.double_arrow),
              content: AppLocalizations.of(context)!.audio_rate,
              suffixWidget: AudioRateDropDown()),
        ],
      ),
    );
  }
}
