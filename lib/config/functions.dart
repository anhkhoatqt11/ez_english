import 'package:ez_english/config/constants.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

String getTranslatedSkill(String skill, BuildContext context) {
  switch (skill) {
    case "Listening":
      return AppLocalizations.of(context)!.listening;
    case "Reading":
      return AppLocalizations.of(context)!.reading;
    case "Writing":
      return AppLocalizations.of(context)!.writing;
    case "Speaking":
      return AppLocalizations.of(context)!.speaking;
  }
  return "";
}

String getPartIntroduction(int part, String skill) {
  if (skill == "Listening" || skill == "Reading") {
    switch (part) {
      case 1:
        return ListeningPart1;
      case 2:
        return ListeningPart2;
      case 3:
        return ListeningPart3;
      case 4:
        return ListeningPart4;
      case 5:
        return ReadingPart5;
      case 6:
        return ReadingPart6;
      case 7:
        return ReadingPart7;
    }
  }
  if (skill == "Writing") {
    switch (part) {
      case 1:
        return WritingPart1;
      case 2:
        return WritingPart2;
      case 3:
        return WritingPart3;
    }
  }
  if (skill == "Speaking") {
    switch (part) {
      case 1:
        return SpeakingPart1;
      case 2:
        return SpeakingPart2;
      case 3:
        return SpeakingPart3;
    }
  }
  return "";
}

int getSecondEachQuestion({required String skill, int part = 0}) {
  switch (skill) {
    case "Listening":
      return 27;
    case "Reading":
      return 45;
    case "Speaking":
      return 45;
    default:
      return 0;
  }
}

String formatDuration(Duration duration) {
  int totalSeconds = duration.inSeconds;
  int minutes = totalSeconds ~/ 60;
  int seconds = totalSeconds % 60;

  if (minutes == 0 && seconds == 0) {
    return '0s';
  } else if (minutes == 0) {
    return "${seconds.toString()}s";
  } else {
    return '${minutes.toString()}m${seconds.toString().padLeft(2, '0')}s';
  }
}
