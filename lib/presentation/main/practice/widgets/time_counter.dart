import 'dart:async';

import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeCounter extends StatelessWidget {
  const TimeCounter(
      {super.key, required this.timeLimit, required this.navigateToNextPage});
  final Duration timeLimit;
  final Function navigateToNextPage;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: ColorManager.primaryTextColor,
      child: TweenAnimationBuilder<Duration>(
          duration: timeLimit,
          tween: Tween(begin: timeLimit, end: Duration.zero),
          onEnd: () async {
            await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        AppLocalizations.of(context)!.time_out,
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),
                    ));
            navigateToNextPage.call();
          },
          builder: (BuildContext context, Duration value, Widget? child) {
            final minutes = value.inMinutes;
            final seconds = value.inSeconds % 60;
            return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('$minutes : $seconds',
                    textAlign: TextAlign.center,
                    style:
                        getSemiBoldStyle(color: Colors.black, fontSize: 14)));
          }),
    );
  }
}
