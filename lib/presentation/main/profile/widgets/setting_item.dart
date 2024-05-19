import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {super.key,
      required this.prefixIcon,
      required this.content,
      required this.suffixWidget});
  final Widget prefixIcon;
  final Widget suffixWidget;
  final String content;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefixIcon,
              const SizedBox(
                width: 4,
              ),
              Expanded(
                  child: Text(
                content,
                textAlign: TextAlign.start,
              )),
              suffixWidget
            ],
          ),
        ),
        const Divider(
          height: 2,
          color: Colors.black26,
          endIndent: 8,
          indent: 8,
        )
      ],
    );
  }
}
