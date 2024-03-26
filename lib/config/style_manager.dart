import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      overflow: TextOverflow.ellipsis);
}

// regular style

TextStyle getRegularStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getRegularStyleWithUnderline(
    {double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color)
      .copyWith(decoration: TextDecoration.underline);
}
// light text style

TextStyle getLightStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// semi bold text style

TextStyle getSemiBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
