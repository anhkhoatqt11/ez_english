import 'package:ez_english/utils/routes/route_name.dart';
import 'package:ez_english/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    );
  }
}
