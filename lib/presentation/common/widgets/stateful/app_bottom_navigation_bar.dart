import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({super.key, required this.pageController});
  PageController pageController;

  @override
  _AppBottomNavigationBarState createState() {
    return _AppBottomNavigationBarState();
  }
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBottomNavItem(ImagePath.homeSvgPath, 'Home', 0),
          _buildBottomNavItem(ImagePath.praticeSvgPath, 'Practice', 1),
          _buildBottomNavItem(ImagePath.testSvgPath, 'Test', 2),
          _buildBottomNavItem(ImagePath.userSvgPath, 'User', 3),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String path, String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          widget.pageController.animateToPage(_selectedIndex,
              duration: Durations.medium1, curve: Curves.linear);
        });
      },
      child: AnimatedContainer(
          width: _selectedIndex == index ? 125 : 50,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          duration: Durations.medium1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _selectedIndex == index
                  ? ColorManager.primaryColor
                  : Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(path,
                  colorFilter: _selectedIndex == index
                      ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                      : null),
              const SizedBox(
                width: 4,
              ),
              AnimatedSize(
                duration: Durations.medium1,
                child: Text(
                  _selectedIndex == index ? title : '',
                  style: getSemiBoldStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          )),
    );
  }
}
