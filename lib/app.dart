import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/config/theme.dart';
import 'package:ez_english/data/data_source/profile_remote_datasource.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/presentation/blocs/app_language/language_changing_cubit.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/l10n/l10n.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar color,
      statusBarIconBrightness: Brightness.dark, // Status bar icons color
    ));
    return BlocProvider(
      create: (context) {
        AppPrefs appPrefs = GetIt.instance<AppPrefs>();
        return AppLanguageCubit(appPrefs.getAppLanguage() ?? DEFAULT_LANG_CODE);
      },
      child: BlocBuilder<AppLanguageCubit, Locale>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.loginRoute,
              onGenerateRoute: Routes.generateRoute,
              theme: getAppTheme(),
              supportedLocales: L10n.all,
              locale: state,
              //Change language here
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ]);
        },
      ),
    );
  }
}
