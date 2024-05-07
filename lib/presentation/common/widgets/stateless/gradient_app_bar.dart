import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientAppBar extends StatelessWidget {
  GradientAppBar({super.key, required this.content, this.prefixIcon});
  String content;
  Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 96,
      decoration: const BoxDecoration(
        gradient: ColorManager.linearGradientPrimary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 12),
              child: prefixIcon ?? Container()),
          Expanded(
            child: Center(
              child: Text(
                content,
                style: getSemiBoldStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Container(
            width: 16,
          )
        ],
      ),
    );
  }
}
