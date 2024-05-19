import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpeakingQuestionPage extends StatefulWidget {
  const SpeakingQuestionPage({super.key});
  
  @override
  _SpeakingQuestionPageState createState() => _SpeakingQuestionPageState();
}

class _SpeakingQuestionPageState extends State<SpeakingQuestionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SpeakingQuestionPageAppBar(),
          const Expanded(
            child: SpeakingQuestionPageBody(1),
          ),  
        ]
      ),
    );
  }
}

class SpeakingQuestionPageAppBar extends StatefulWidget {
  @override
  _SpeakingQuestionPageAppBarState createState() => _SpeakingQuestionPageAppBarState();
}

class _SpeakingQuestionPageAppBarState extends State<SpeakingQuestionPageAppBar> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 96,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: ColorManager.linearGradientPrimary,
          ),
          child: Column(
            children: <Widget>[ 
              const SizedBox(height: 60),
              Text(
                'practiceType',
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(color: Colors.white, fontSize: 14)
              ),
            ],
          ),     
        ),
        Positioned(
          top: 63,
          left: 34,
          child: InkWell(
            onTap: () {},
            child: const SizedBox(
              height: 15.63,
              width: 10.09,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15.63,
              )
            ),
          ),
        ),
      ]
    );
  }
}

class SpeakingQuestionPageBody extends StatefulWidget {
  final int questionIndex;

  const SpeakingQuestionPageBody(this.questionIndex);

  @override
  _SpeakingQuestionPageBodyState createState() => _SpeakingQuestionPageBodyState();
}

class _SpeakingQuestionPageBodyState extends State<SpeakingQuestionPageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 22,
          padding: const EdgeInsets.only(left: 34),
          child: Text(
            '${AppLocalizations.of(context)!.question} ${widget.questionIndex}',
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14)
          ),
        ),
        SizedBox(
          height: 520,
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 150),
                Text(
                  'wordToPronounce',
                  style: getBoldStyle(color: Colors.black, fontSize: 30),
                ),
                const SizedBox(height: 160),
                RecordingAttribute(3),
                const SizedBox(height: 20),
                InkWell(
                  onLongPress: () {},
                  splashColor: Colors.blue,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: ColorManager.linearGradientPrimary,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white, width: 1)
                    ),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 80,
                    )
                  )
                ),
              ],
            ),
          )
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: CommonButton(text: AppLocalizations.of(context)!.next),
        ),
        const SizedBox(height: 23)
      ],
    );
  }
}

class RecordingAttribute extends StatefulWidget {
  int index;

  RecordingAttribute(this.index);

  @override
  _RecordingAttributeState createState() => _RecordingAttributeState();
}

class _RecordingAttributeState extends State<RecordingAttribute> {
  @override
  Widget build(BuildContext context) {
    if (widget.index == 0)
    { 
      return Text(
        AppLocalizations.of(context)!.press_and_hold,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      ); 
    }
    else if (widget.index == 1)
    {
      return Text(
        AppLocalizations.of(context)!.recording,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
    else if (widget.index == 2)
    {
      return Text(
        AppLocalizations.of(context)!.incorrect_try_again,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
    else
    {
      return Text(
        AppLocalizations.of(context)!.correct,
        style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
      );
    }
  }
}

