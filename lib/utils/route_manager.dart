import 'package:ez_english/presentation/main/main_view.dart';
import 'package:ez_english/presentation/main/test/test_information_page.dart';
import 'package:ez_english/presentation/splash/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/presentation/login/login_page.dart';
import 'package:ez_english/presentation/register/register_page.dart';
import 'package:ez_english/presentation/main/home/home_page.dart';
import 'package:ez_english/presentation/main/practice/practice_page.dart';
import 'package:ez_english/presentation/main/practice/listening/listening_practice_page.dart';
import 'package:ez_english/presentation/main/practice/listening/listening_question_page.dart';
import 'package:ez_english/presentation/main/practice/speaking/speaking_practice_page.dart';
import 'package:ez_english/presentation/main/practice/speaking/speaking_question_page.dart';


class RoutesName {
  static const String splashRoute = "splash";
  static const String loginRoute = "login";
  static const String registerRoute = "register";
  static const String mainRoute = "main";
  static const String testInformation = "testInformation";
  static const String homeRoute = "home";
  static const String practiceRoute = "practice";
  static const String listeningPracticeRoute = "listening_practice";
  static const String listeningQuestionRoute = "listening_question";
  static const String speakingPracticeRoute = "speaking_practice";
  static const String speakingQuestionRoute = "speaking_question";
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
      case RoutesName.testInformation:
        return MaterialPageRoute(builder: (_) => const TestInformationPage());
      case RoutesName.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesName.practiceRoute:
        return MaterialPageRoute(builder: (_) => const PracticePage());
      case RoutesName.listeningPracticeRoute:
        return MaterialPageRoute(builder: (_) => const ListeningPage());
      case RoutesName.listeningQuestionRoute:
        return MaterialPageRoute(builder: (_) => const ListeningQuestionPage());
      case RoutesName.speakingPracticeRoute:
        return MaterialPageRoute(builder: (_) => const SpeakingPage());
      case RoutesName.speakingQuestionRoute:
        return MaterialPageRoute(builder: (_) => const SpeakingQuestionPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                    body: Center(
                  child: Text('No route defined'),
                )));
    }
  }
}
