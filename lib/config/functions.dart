import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';

Future<T?> showAnimatedDialog1<T extends Object?>(
    BuildContext context, Widget dialog) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return dialog;
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
        child: child,
      );
    },
  );
}

void showExplanation(String explanation, BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.6,
            child: Text(
              explanation,
              style: getRegularStyle(color: Colors.black),
              maxLines: 100,
            ),
          ),
        );
      });
}
