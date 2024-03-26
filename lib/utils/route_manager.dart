import 'package:ez_english/presentation/main/main_view.dart';
import 'package:ez_english/presentation/splash/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/presentation/login/login_page.dart';
import 'package:ez_english/presentation/register/register_page.dart';

class RoutesName {
  static const String splashRoute = "splash";
  static const String loginRoute = "login";
  static const String registerRoute = "register";
  static const String mainRoute = "main";
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesName.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutesName.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case RoutesName.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                    body: Center(
                  child: Text('No route defined'),
                )));
    }
  }
}
