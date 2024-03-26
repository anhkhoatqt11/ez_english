import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagePath.logoPath,
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'ezEnglish',
              style: TextStyle(
                color: ColorManager.textLogoColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
