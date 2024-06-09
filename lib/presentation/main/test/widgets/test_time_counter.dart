import 'dart:async';

import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/blocs/test/test_bloc.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TestTimeCounter extends StatefulWidget {
  const TestTimeCounter(
      {super.key, required this.timeLimit, required this.navigateToNextPage});

  final Duration timeLimit;
  final Function navigateToNextPage;
  @override
  State<TestTimeCounter> createState() => _TestTimeCounterState();
}

class _TestTimeCounterState extends State<TestTimeCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Duration> _animation;
  bool _isPaused = false;
  final TestBloc testBloc = GetIt.instance<TestBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.timeLimit,
    );

    _animation =
        Tween(begin: widget.timeLimit, end: Duration.zero).animate(_controller);
    _animation.addListener(onEndAnimation);
    // Start the animation
    _controller.forward();
  }

  Future<void> onEndAnimation() async {
    if (_animation.isCompleted) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  AppLocalizations.of(context)!.time_out,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
              ));
      widget.navigateToNextPage.call();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animation.removeListener(onEndAnimation);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<TestBloc, TestState>(
      bloc: testBloc,
      listener: (context, state) {
        if (state is TestPauseTimeState) {
          _controller.stop();
        }
        if (state is TestContinueTimeState) {
          _controller.forward();
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: ColorManager.primaryTextColor,
        /*child: TweenAnimationBuilder<Duration>(
          duration: widget.timeLimit,
          tween: Tween(begin: widget.timeLimit, end: Duration.zero),
          onEnd: () {
            print('Timer ended');
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
          }),*/
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final minutes = _animation.value.inMinutes;
            final seconds = _animation.value.inSeconds % 60;
            return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('$minutes : $seconds',
                    textAlign: TextAlign.center,
                    style:
                        getSemiBoldStyle(color: Colors.black, fontSize: 14)));
          },
        ),
      ),
    );
  }
}
