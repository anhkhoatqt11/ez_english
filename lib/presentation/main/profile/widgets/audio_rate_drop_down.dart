import 'package:ez_english/app_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class AudioRateDropDown extends StatelessWidget {
  AudioRateDropDown({super.key});
  final List<double> volumeList = [0.5, 0.75, 1.0, 1.25];
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
            appPrefs.setAudioRate(value);
          }
        },
        initialSelection: appPrefs.getAudioRate() ?? 1.0,
        dropdownMenuEntries: [
          ...volumeList.map(
            (e) => DropdownMenuEntry(value: e, label: e.toString()),
          )
        ]);
  }
}
