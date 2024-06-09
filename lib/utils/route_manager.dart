import 'package:ez_english/dependency_injection.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/presentation/entry_test/entry_test.dart';
import 'package:ez_english/presentation/entry_test/entry_test_introduction.dart';
import 'package:ez_english/presentation/entry_test/entry_test_result.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/main/main_view.dart';
import 'package:ez_english/presentation/main/practice/listening/listening_question_page.dart';
import 'package:ez_english/presentation/main/practice/reading/reading_question_page.dart';
import 'package:ez_english/presentation/main/practice/skill_practice_page.dart';
import 'package:ez_english/presentation/main/profile/progress/progress_page.dart';
import 'package:ez_english/presentation/main/test/taking_test_page.dart';
import 'package:ez_english/presentation/main/test/test_information_page.dart';
import 'package:ez_english/presentation/main/test/test_list_page.dart';
import 'package:ez_english/presentation/main/test/widgets/test_item.dart';
import 'package:ez_english/presentation/part_info/part_info_page.dart';
import 'package:ez_english/presentation/password_reset/password_reset_page.dart';
import 'package:ez_english/presentation/result/result_practice_page.dart';
import 'package:ez_english/presentation/result/result_test_page.dart';
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
import 'package:ez_english/presentation/main/practice/speaking/speaking_result_page.dart';

class RoutesName {
  static const String splashRoute = "splash";
  static const String loginRoute = "login";
  static const String registerRoute = "register";
  static const String passwordRecoveryRoute = "password_recovery";
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
  static const String entryTestIntroductionRoute = "entry_test_introduction";
  static const String entryTestRoute = "entry_test";
  static const String entryTestResultRoute = "entry_test_result";
  static const String resultPracticeRoute = "result_practice";
  static const String partInfoRoute = "part_info";
  static const String speakingResultRoute = "speaking_result";
  static const String testListRoute = "test_list";
  static const String takingTestRoute = "taking_test";
  static const String progressRoute = "progress";
  static const String resultTestRoute = "test_result";
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
      case RoutesName.passwordRecoveryRoute:
        return MaterialPageRoute(builder: (_) => const PasswordResetPage());
      case RoutesName.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case RoutesName.takingTestRoute:
        return MaterialPageRoute(
            builder: (_) => TakingTestPage(
                  testItem: (settings.arguments as List<dynamic>)[0],
                  skills: (settings.arguments as List<dynamic>)[1],
                ));
      case RoutesName.testListRoute:
        return MaterialPageRoute(
            builder: (_) =>
                TestListPage(testCategory: settings.arguments as TestCategory));
      case RoutesName.testInformation:
        return MaterialPageRoute(
            builder: (_) => TestInformationPage(
                  testItem: (settings.arguments as List<dynamic>)[0],
                  skills: (settings.arguments as List<dynamic>)[1],
                ));
      case RoutesName.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesName.practiceRoute:
        return MaterialPageRoute(builder: (_) => const PracticePage());
      case RoutesName.partInfoRoute:
        List<dynamic> arguments = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => PartInfoPage(
                isPractice: arguments[0], partObject: arguments[1]));
      case RoutesName.resultPracticeRoute:
        List<Object> arguments = settings.arguments as List<Object>;
        return MaterialPageRoute(
            builder: (_) => ResultPracticePage(
                answerMap: arguments[0] as Map<int, String>,
                part: arguments[1] as PartObject,
                limit: arguments[2] as int));
      case RoutesName.resultTestRoute:
        List<Object> arguments = settings.arguments as List<Object>;
        return MaterialPageRoute<bool?>(
            builder: (_) => ResultTestPage(
                  answerMap: arguments[0] as Map<int, String>,
                  skills: arguments[1] as List<String?>,
                  testItem: arguments[2] as Test,
                ));
      case RoutesName.skillPracticeRoute:
        return MaterialPageRoute(
            builder: (_) =>
                SkillPracticePage(skill: settings.arguments as String));
      case RoutesName.listeningQuestionRoute:
        initQuestionPageModule();
        List<dynamic> arguments = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => ListeningQuestionPage(
                part: arguments[0],
                timeLimit: arguments[1],
                limit: arguments[2]));
      case RoutesName.readingQuestionRoute:
        initQuestionPageModule();
        List<dynamic> arguments = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => ReadingQuestionPage(
                part: arguments[0],
                timeLimit: arguments[1],
                limit: arguments[2]));
      case RoutesName.speakingQuestionRoute:
        initQuestionPageModule();
        List<dynamic> arguments = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => SpeakingQuestionPage(
                  part: arguments[0],
                  timeLimit: arguments[1],
                  numOfQuestion: arguments[2],
                ));
      case RoutesName.speakingResultRoute:
        List<dynamic> arguments = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) => SpeakingResultPage(
                  isCorrectList: arguments[0] as List<Map<bool, String>>,
                  part: arguments[1] as int,
                ));
      case RoutesName.tipDetailRoute:
        initQuestionPageModule();
        return MaterialPageRoute(
            builder: (_) => TipDetail(
                title: (settings.arguments as Map)['title'],
                content: (settings.arguments as Map)['content']));
      case RoutesName.newTipRoute:
        return MaterialPageRoute(builder: (_) => const NewTipPage());
      case RoutesName.entryTestIntroductionRoute:
        return MaterialPageRoute(
            builder: (_) => const EntryTestIntroductionPage());
      case RoutesName.entryTestRoute:
        return MaterialPageRoute(builder: (_) => const EntryTestPage());
      case RoutesName.entryTestResultRoute:
        return MaterialPageRoute(
            builder: (_) =>
                EntryTestResultPage(level: settings.arguments as String));
      case RoutesName.progressRoute:
        return MaterialPageRoute(builder: (_) => const ProgressPage());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                    body: Center(
                  child: Text('No route defined'),
                )));
    }
  }
}
