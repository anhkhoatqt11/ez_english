import 'package:ez_english/config/constants.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/domain/model/answer.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/main/practice/widgets/explanation_bottom_sheet.dart';
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

void showExplanation(List<Answer> answerList, BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return ExplanationBottomSheet(answerList);
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

List<PartObject> getPartByTest(List<String?> skills, BuildContext context) {
  List<PartObject> partList = [];
  for (String? skillItem in skills) {
    if (skillItem != null) {
      switch (skillItem) {
        case "Listening":
          partList.addAll([
            PartObject(1, AppLocalizations.of(context)!.photographs, skillItem),
            PartObject(
                2, AppLocalizations.of(context)!.question_response, skillItem),
            PartObject(
                3, AppLocalizations.of(context)!.conversations, skillItem),
            PartObject(4, AppLocalizations.of(context)!.talks, skillItem),
          ]);
        case "Reading":
          partList.addAll([
            PartObject(5, AppLocalizations.of(context)!.incomplete_sentences,
                skillItem),
            PartObject(
                6, AppLocalizations.of(context)!.text_completion, skillItem),
            PartObject(7, AppLocalizations.of(context)!.reading_comprehension,
                skillItem),
          ]);
        case "Writing":
          partList.addAll([
            PartObject(
                1,
                AppLocalizations.of(context)!.write_sentence_based_on_picture,
                skillItem),
            PartObject(2, AppLocalizations.of(context)!.respond_written_request,
                skillItem),
            PartObject(3, AppLocalizations.of(context)!.write_opinion_essay,
                skillItem),
          ]);
        case "Speaking":
          partList.addAll([
            PartObject(
                1, AppLocalizations.of(context)!.read_aloud_word, skillItem),
            PartObject(
                2, AppLocalizations.of(context)!.describe_picture, skillItem),
            PartObject(
                3, AppLocalizations.of(context)!.pronounce_audio, skillItem),
          ]);
      }
    }
  }
  return partList;
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

int convertRawScoreToScaledScore(
    int correctAnswers, int maxRawScore, int minScore, int maxScore) {
  if (correctAnswers < 0) correctAnswers = 0;
  if (correctAnswers > maxRawScore) correctAnswers = maxRawScore;

  double scalingFactor = (maxScore - minScore) / maxRawScore;
  return (correctAnswers * scalingFactor + minScore).round();
}

// Calculate TOEIC score
Map<String, int> calculateToeicScore(
    List<String?> skills, int listeningCorrect, int readingCorrect) {
  const int maxRawScore = 100;
  const int minScore = 5;
  const int maxScore = 495;

  int skill1 = convertRawScoreToScaledScore(
      listeningCorrect, maxRawScore, minScore, maxScore);
  int skill2 = convertRawScoreToScaledScore(
      readingCorrect, maxRawScore, minScore, maxScore);

  return {
    skills[0]!: skill1,
    skills[1]!: skill2,
    'Total': skill1 + skill2,
  };
}

bool compareLevel(String userLevel, String requiredLevel) {
  List<String> levels = ["Beginner", "Intermediate", "Advanced"];
  return levels.indexOf(userLevel) >= levels.indexOf(requiredLevel);
}
