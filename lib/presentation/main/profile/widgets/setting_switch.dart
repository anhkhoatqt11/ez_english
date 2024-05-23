import 'package:ez_english/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingSwitch extends StatefulWidget {
  SettingSwitch({super.key, required this.isTrue});
  bool isTrue;
  @override
  _SettingSwitchState createState() {
    return _SettingSwitchState();
  }
}

class _SettingSwitchState extends State<SettingSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Switch(
      value: widget.isTrue,
      onChanged: (value) {
        setState(() {
          widget.isTrue = value;
          GetIt.instance<AppPrefs>().setAutoChangeQuestion(value);
        });
      },
    );
  }
}
