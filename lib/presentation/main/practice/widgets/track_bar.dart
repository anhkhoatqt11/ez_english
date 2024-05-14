import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../config/color_manager.dart';
import '../../../../config/style_manager.dart';

class TrackBar extends StatefulWidget {
  String audioUrl;

  TrackBar({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _TrackBarState createState() => _TrackBarState();
}

class _TrackBarState extends State<TrackBar> {
  AudioPlayer player = AudioPlayer();
  Duration audioDuration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFuncForAudio();
    player.play(UrlSource(widget.audioUrl));
  }

  void initFuncForAudio() {
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        audioDuration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 32),
      decoration: BoxDecoration(
        color: ColorManager.primaryTextColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Duration nextPosition =
                        Duration(seconds: position.inSeconds - 5);
                    player.seek(nextPosition);
                  },
                  child: const Icon(
                    textDirection: TextDirection.rtl,
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
              InkWell(
                  onTap: () {
                    if (isPlaying) {
                      player.pause();
                    } else {
                      if (player.state == PlayerState.completed) {
                        player.play(UrlSource(widget.audioUrl));
                      } else {
                        player.resume();
                      }
                    }
                  },
                  child: isPlaying
                      ? const Icon(
                          Icons.pause,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        )),
              InkWell(
                  onTap: () {
                    Duration nextPosition =
                        Duration(seconds: position.inSeconds + 5);
                    player.seek(nextPosition);
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )),
            ],
          ),
          Text(formatTime(position.inSeconds),
              style: getSemiBoldStyle(color: Colors.white, fontSize: 14)),
          Expanded(
            child: SizedBox(
              child: Slider(
                value: position.inSeconds.toDouble(),
                max: audioDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  final newPosition = Duration(seconds: value.toInt());
                  player.seek(newPosition);
                  player.resume();
                },
                activeColor: ColorManager.primaryColor,
                inactiveColor: Colors.white,
              ),
            ),
          ),
          Text(formatTime(audioDuration.inSeconds),
              style: getSemiBoldStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
