import 'package:ez_english/pages/login/login_page.dart';
import 'package:ez_english/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/utils/routes/route_name.dart';
import 'package:flutter/widgets.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case RoutesName.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutesName.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
          body: Center(
            child: Text('No route defined'),
          )
        ));
    }
  }
}