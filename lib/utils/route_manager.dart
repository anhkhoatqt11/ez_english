import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/presentation/login/login_page.dart';
import 'package:ez_english/presentation/register/register_page.dart';

class RoutesName {
  static const String loginRoute = "login";
  static const String registerRoute = "register";
}

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutesName.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                    body: Center(
                  child: Text('No route defined'),
                )));
    }
  }
}
