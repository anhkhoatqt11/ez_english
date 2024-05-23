import 'package:shared_preferences/shared_preferences.dart';

String LANG_CODE_KEY = 'LANG-CODE';
String AUTO_CHANGE_QUESTION = 'AUTO-CHANGE-QUESTION';
String AUDIO_VOL = 'AUDIO-VOLUME';
String AUDIO_RATE = 'AUDIO-RATE';
String HORIZONTAL_LAYOUT = 'HORIZONTAL-LAYOUT';

class AppPrefs {
  SharedPreferences _sharedPreferences;

  AppPrefs(this._sharedPreferences);

  void setAppLanguage(String langCode) {
    _sharedPreferences.setString(LANG_CODE_KEY, langCode);
  }

  String? getAppLanguage() {
    return _sharedPreferences.getString(LANG_CODE_KEY);
  }

  bool? getAutoChangeQuestion() {
    return _sharedPreferences.getBool(AUTO_CHANGE_QUESTION);
  }

  void setAutoChangeQuestion(bool isAuto) {
    _sharedPreferences.setBool(AUTO_CHANGE_QUESTION, isAuto);
  }

  double? getAudioVolume() {
    return _sharedPreferences.getDouble(AUDIO_VOL);
  }

  void setAudioVolume(double newVolume) {
    _sharedPreferences.setDouble(AUDIO_VOL, newVolume);
  }

  double? getAudioRate() {
    return _sharedPreferences.getDouble(AUDIO_RATE);
  }

  void setAudioRate(double newRate) {
    _sharedPreferences.setDouble(AUDIO_RATE, newRate);
  }

  bool? getHorizontalAnswerBarLayout() {
    return _sharedPreferences.getBool(HORIZONTAL_LAYOUT);
  }

  void setHorizontalAnswerBarLayout(bool isHorizontal) {
    _sharedPreferences.setBool(HORIZONTAL_LAYOUT, isHorizontal);
  }
}
