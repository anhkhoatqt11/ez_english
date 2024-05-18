import 'package:ez_english/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class AudioVolumeDropDown extends StatelessWidget {
  AudioVolumeDropDown({super.key});
  final List<int> volumeList = [0, 25, 50, 75, 100];
  final AppPrefs appPrefs = GetIt.instance<AppPrefs>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownMenu(
        inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(left: 12),
            isCollapsed: true,
            constraints: BoxConstraints.tightForFinite(height: 40)),
        onSelected: (value) {
          if (value != null) {
            appPrefs.setAudioVolume(value as double);
          }
        },
        initialSelection: appPrefs.getAudioVolume() ?? 100,
        dropdownMenuEntries: [
          ...volumeList.map(
            (e) => DropdownMenuEntry(value: e, label: e.toString()),
          )
        ]);
  }
}
