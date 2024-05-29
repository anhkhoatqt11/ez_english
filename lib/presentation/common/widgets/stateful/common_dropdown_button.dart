import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ez_english/presentation/common/objects/mutable_variable.dart';
import 'package:flutter/material.dart';

class CommonDropdownButton extends StatefulWidget {
  const CommonDropdownButton(
      {super.key, required this.data, required this.selectedItem});

  final List<dynamic> data;
  final MutableVariable<dynamic> selectedItem;

  @override
  _CommonDropdownButtonState createState() {
    return _CommonDropdownButtonState();
  }
}

class _CommonDropdownButtonState extends State<CommonDropdownButton> {
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
    return Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          items: [
            ...widget.data.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              ),
            )
          ],
          value: widget.selectedItem.value,
          onChanged: (dynamic value) {
            if (value != null) {
              setState(() {
                widget.selectedItem.setValue(value);
              });
            }
          },
          buttonStyleData: const ButtonStyleData(
              height: 30, width: 60, padding: EdgeInsets.only(left: 8)),
        ),
      ),
    );
  }
}
