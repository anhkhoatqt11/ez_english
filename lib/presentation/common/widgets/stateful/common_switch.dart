import 'package:ez_english/presentation/common/objects/mutable_variable.dart';
import 'package:flutter/material.dart';

class CommonSwitch extends StatefulWidget {
  const CommonSwitch({super.key, required this.isTest});
  final MutableVariable<bool> isTest;
  @override
  _CommonSwitchState createState() {
    return _CommonSwitchState();
  }
}

class _CommonSwitchState extends State<CommonSwitch> {
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
      value: widget.isTest.value,
      onChanged: (value) {
        setState(() {
          widget.isTest.setValue(value);
        });
      },
    );
  }
}
