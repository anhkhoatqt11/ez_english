import 'package:ez_english/presentation/common/widgets/stateful/app_bottom_navigation_bar.dart';
import 'package:ez_english/presentation/main/home/home_page.dart';
import 'package:ez_english/presentation/main/practice/practice_page.dart';
import 'package:ez_english/presentation/main/test/test_page.dart';
import 'package:ez_english/presentation/main/user/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    const UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) => pages[index],
        controller: _pageController,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        pageController: _pageController,
      ),
    );
  }
}
