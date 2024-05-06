import 'package:bloc/bloc.dart';
import 'package:ez_english/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppLanguageCubit extends Cubit<Locale> {
  AppLanguageCubit(this.appLangCode) : super(Locale(appLangCode));
  String appLangCode;
  void changeLanguage(String langCode) {
    emit(Locale(langCode));
  }
}
