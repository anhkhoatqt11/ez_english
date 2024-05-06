import 'package:ez_english/app_prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _instance = GetIt.instance;
Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  _instance.registerLazySingleton<AppPrefs>(() => AppPrefs(sharedPreferences));
}
