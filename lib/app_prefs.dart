import 'package:shared_preferences/shared_preferences.dart';

String LANG_CODE_KEY = 'LANG-CODE';

class AppPrefs {
  SharedPreferences _sharedPreferences;

  AppPrefs(this._sharedPreferences);

  void setAppLanguage(String langCode) {
    _sharedPreferences.setString(LANG_CODE_KEY, langCode);
  }

  String? getAppLanguage() {
    return _sharedPreferences.getString(LANG_CODE_KEY);
  }
}
