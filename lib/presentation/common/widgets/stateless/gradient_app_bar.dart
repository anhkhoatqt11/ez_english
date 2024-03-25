import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  GradientAppBar({super.key, required this.content});
  String content;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: AlignmentDirectional.bottomCenter,
      width: double.infinity,
      height: 96,
      decoration: const BoxDecoration(
        gradient: ColorManager.linearGradientPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          content,
          style: getSemiBoldStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
