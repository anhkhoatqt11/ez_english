import 'package:ez_english/config/theme.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/l10n/l10n.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar color,
      statusBarIconBrightness: Brightness.dark, // Status bar icons color
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.registerRoute,
        onGenerateRoute: Routes.generateRoute,
        theme: getAppTheme(),
        supportedLocales: L10n.all,
        locale: const Locale('en'), //Change language here
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ]);
  }
}
