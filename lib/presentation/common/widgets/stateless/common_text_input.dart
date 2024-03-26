import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextInput extends StatelessWidget {
  const CommonTextInput(
      {Key? key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.obsucure})
      : super(key: key);
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obsucure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: ColorManager.inputBgColor,
          border: Border.all(
            color: ColorManager.inputBorderColor,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obsucure,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
        ),
        style:
            getLightStyle(color: ColorManager.darkSlateGrayColor, fontSize: 14),
      ),
    );
  }
}
