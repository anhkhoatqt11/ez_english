import 'package:ez_english/config/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme() {
  return ThemeData(
      textTheme: GoogleFonts.lexendTextTheme(),
      colorSchemeSeed: ColorManager.primaryColor);
}
