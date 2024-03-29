import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';

class SpeakingPage extends StatefulWidget {
  const SpeakingPage({super.key});

  @override
  _SpeakingPageState createState() => _SpeakingPageState();
}

class _SpeakingPageState extends State<SpeakingPage> {

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
          SpeakingPageAppBar(),
          Expanded(
            child: SpeakingPageBody(),
          ),  
        ]
      ),
    );
  }
}

class SpeakingPageAppBar extends StatefulWidget {
  @override
  _SpeakingPageAppBarState createState() => _SpeakingPageAppBarState();
}

class _SpeakingPageAppBarState extends State<SpeakingPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: const BoxDecoration(
        gradient: ColorManager.linearGradientPrimary,
      ),
      padding: const EdgeInsets.only(top: 63, left: 34),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
          ),
          const SizedBox(width: 12.91),
          Text(
            'Speaking', 
            style: getSemiBoldStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      )
    );
  }
}

class SpeakingPageBody extends StatefulWidget {
  @override
  _SpeakingPageBodyState createState() => _SpeakingPageBodyState();
}

class _SpeakingPageBodyState extends State<SpeakingPageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 39),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                'Speaking Practice',
                style: getSemiBoldStyle(color: Colors.black, fontSize: 24),
              ),
              const SizedBox(height: 9),
              Text(
                'Choose once to begin',
                style: getSemiBoldStyle(color: ColorManager.lightTextColor, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        SpeakingPracticeList(),
      ]
    );
  }
}

class SpeakingPracticeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SpeakingPracticeItem('Speaking Practice 1'),
        SpeakingPracticeItem('Speaking Practice 2'),
        SpeakingPracticeItem('Speaking Practice 3'),
        SpeakingPracticeItem('Speaking Practice 4'),
        SpeakingPracticeItem('Speaking Practice 1'),
        SpeakingPracticeItem('Speaking Practice 2'),
        SpeakingPracticeItem('Speaking Practice 3'),
        SpeakingPracticeItem('Speaking Practice 4'),
        SpeakingPracticeItem('Speaking Practice 1'),
        SpeakingPracticeItem('Speaking Practice 2'),
        SpeakingPracticeItem('Speaking Practice 3'),
        SpeakingPracticeItem('Speaking Practice 4'),
      ],
    );
  }
}

class SpeakingPracticeItem extends StatelessWidget {
  final String practiceName;

  SpeakingPracticeItem(this.practiceName);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Tapped');
      },
      child: Container(
        height: 106,
        width: 324,
        margin: const EdgeInsets.only(bottom: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, 
              spreadRadius: 5, 
              blurRadius: 8, 
              offset: const Offset(0, 3), 
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 17),
            Row(
              children: <Widget>[
                const SizedBox(width: 18),
                Container(
                  width: 47,
                  height: 47,
                  decoration: const BoxDecoration(
                    color: ColorManager.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'practiceType',
                      style: getSemiBoldStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      'corectAnswer / totalQuestion',
                      style: getLightStyle(color: Colors.black, fontSize: 8),
                    ),
                  ]
                )
              ]
            ),
            const SizedBox(height: 17),
            Row(
              children: <Widget>[
                const SizedBox(width: 20),
                Text(
                  'Progress',
                  style: getLightStyle(color: Colors.black, fontSize: 8),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 246,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: ColorManager.secondaryColor, 
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      value: 0.5, 
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primaryColor), 
                    ),
                  )
                )
              ],
            )
          ],
        )
      ),
    );
  }
}