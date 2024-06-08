import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';

class ProgressAppBar extends StatelessWidget implements PreferredSizeWidget {
  ProgressAppBar({
    super.key,
    required this.content,
    this.prefixIcon,
    this.suffixIcon,
    required this.userImage,
    required this.userName,
    required this.userTitle,
    this.progress = 0.0,
  });

  final String content;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget userImage;
  final String userName;
  final String userTitle;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 40, bottom: 10), // Adjust padding to fit the user image
      decoration: const BoxDecoration(
        gradient: ColorManager.linearGradientPrimary,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: prefixIcon ?? Container(),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    content,
                    style: getSemiBoldStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: suffixIcon ?? Container(),
              ),
              Container(
                width: 16,
              )
            ],
          ),
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              ClipOval(child: userImage),
            ],
          ),
          SizedBox(height: 10),
          Text(
            userName,
            style: getSemiBoldStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            userTitle,
            style: getRegularStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(200); // Adjust the height based on the content
}
