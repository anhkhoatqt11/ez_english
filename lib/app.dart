import 'package:ez_english/utils/routes/route_name.dart';
import 'package:ez_english/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/l10n/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.loginRoute,
      onGenerateRoute: Routes.generateRoute,
      theme: ThemeData(
        textTheme: GoogleFonts.lexendTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      supportedLocales: L10n.all,
      locale: const Locale('vi'), //Change language here
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ]
    );
  }
}
