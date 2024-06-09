import 'package:ez_english/config/constants.dart';
import 'package:ez_english/dependency_injection.dart';
import 'package:ez_english/domain/usecase/get_all_test_categories_usecase.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/presentation/common/widgets/stateful/app_bottom_navigation_bar.dart';
import 'package:ez_english/presentation/main/home/home_page.dart';
import 'package:ez_english/presentation/main/practice/practice_page.dart';
import 'package:ez_english/presentation/main/profile/profile_page.dart';
import 'package:ez_english/presentation/main/test/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> pages = [
    const HomePage(),
    const PracticePage(),
    const TestPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          switch (index) {
            case 2:
              initTestInfoModule();
              break;
          }
          return pages[index];
        },
        controller: _pageController,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        pageController: _pageController,
      ),
    );
  }
}
