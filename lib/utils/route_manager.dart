import 'package:ez_english/dependency_injection.dart';
import 'package:ez_english/presentation/main/main_view.dart';
import 'package:ez_english/presentation/main/practice/listening/listening_question_page.dart';
import 'package:ez_english/presentation/main/practice/reading/reading_question_page.dart';
import 'package:ez_english/presentation/main/practice/skill_practice_page.dart';
import 'package:ez_english/presentation/main/test/test_information_page.dart';
import 'package:ez_english/presentation/splash/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/presentation/login/login_page.dart';
import 'package:ez_english/presentation/register/register_page.dart';
import 'package:ez_english/presentation/main/home/home_page.dart';
import 'package:ez_english/presentation/main/home/tip/tip_detail.dart';
import 'package:ez_english/presentation/main/home/tip/new_tip_page.dart';
import 'package:ez_english/presentation/main/practice/practice_page.dart';
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
  static const String readingQuestionRoute = "reading_question";
  static const String speakingPracticeRoute = "speaking_practice";
  static const String speakingQuestionRoute = "speaking_question";
  static const String readingPracticeRoute = "reading_practice";
  static const String writingPracticeRoute = "writing_practice";
  static const String skillPracticeRoute = "skill_practice";
  static const String tipDetailRoute = "tip_detail";
  static const String newTipRoute = "new_tip";
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
      case RoutesName.skillPracticeRoute:
        return MaterialPageRoute(
            builder: (_) =>
                SkillPracticePage(skill: settings.arguments as String));
      case RoutesName.listeningQuestionRoute:
        initQuestionPageModule();
        return MaterialPageRoute(
            builder: (_) => ListeningQuestionPage(
                  part: settings.arguments as int,
                ));
      case RoutesName.readingQuestionRoute:
        initQuestionPageModule();
        return MaterialPageRoute(
            builder: (_) => ReadingQuestionPage(
                  part: settings.arguments as int,
                ));
      case RoutesName.speakingQuestionRoute:
        initQuestionPageModule();
        return MaterialPageRoute(
            builder: (_) => SpeakingQuestionPage(
                  part: settings.arguments as int,
                ));
      case RoutesName.tipDetailRoute:
        initQuestionPageModule();
        return MaterialPageRoute(
            builder: (_) => TipDetail(
                title: (settings.arguments as Map)['title'],
                content: (settings.arguments as Map)['content']
                ));
      case RoutesName.newTipRoute:
        return MaterialPageRoute(builder: (_) => const NewTipPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                    body: Center(
                  child: Text('No route defined'),
                )));
    }
  }
}
