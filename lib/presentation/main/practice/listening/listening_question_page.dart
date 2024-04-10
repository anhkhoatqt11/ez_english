import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListeningQuestionPage extends StatefulWidget {
  const ListeningQuestionPage({super.key});
  
  @override
  _ListeningQuestionPageState createState() => _ListeningQuestionPageState();
}

class _ListeningQuestionPageState extends State<ListeningQuestionPage> {
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
          ListeningQuestionPageAppBar(),
          Expanded(
            child: ListeningQuestionPageBody(1),
          ),  
        ]
      ),
    );
  }
}

class ListeningQuestionPageAppBar extends StatefulWidget {
  @override
  _ListeningQuestionPageAppBarState createState() => _ListeningQuestionPageAppBarState();
}

class _ListeningQuestionPageAppBarState extends State<ListeningQuestionPageAppBar> {

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

class ListeningQuestionPageBody extends StatefulWidget {
  final int questionIndex;

  const ListeningQuestionPageBody(this.questionIndex);

  @override
  _ListeningQuestionPageBodyState createState() => _ListeningQuestionPageBodyState();
}

class _ListeningQuestionPageBodyState extends State<ListeningQuestionPageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          width: 340,
          height: 255,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        const SizedBox(height: 32),
        TrackBar(),
        const SizedBox(height: 100),
        Container(
          height: 22,
          padding: const EdgeInsets.only(left: 34),
          child: Text(
            AppLocalizations.of(context)!.question + ' ${widget.questionIndex}',
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14)
          ),
        ),
        const SizedBox(height: 32),
        AnswerBar(),
        const SizedBox(height: 32),
        Container(
          width: 309,
          child: CommonButton(text: AppLocalizations.of(context)!.next),
        ),
        const SizedBox(height: 23)
      ],
    );
  }
}

class TrackBar extends StatefulWidget {
  double _value = 0.0;

  TrackBar({Key? key}) : super(key: key);

  @override
  _TrackBarState createState() => _TrackBarState();
}

class _TrackBarState extends State<TrackBar> {
  void changeValue(double value){
    setState(() {
      widget._value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 346,
      height: 38,
      decoration: BoxDecoration(
        color: ColorManager.secondaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          InkWell(
            onTap: (){},
            child: Container(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                )
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: (){},
            child: Container(
              child: const Icon(
                Icons.pause,
                color: Colors.white,
                size: 20,
              )
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: (){},
            child: Container(
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                )
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '00:00',
            style: getSemiBoldStyle(color: Colors.white, fontSize: 14)
          ),
          Container(
            width: 180,
            child: Slider(
              value: widget._value,
              min: 0.0,
              max: 100.0,
              onChanged: (value) {
                changeValue(value);
              },
              activeColor: ColorManager.primaryColor,
              inactiveColor: Colors.white,
            ),
          ),
          Text(
            '00:00',
            style: getSemiBoldStyle(color: Colors.white, fontSize: 14)
          ),
        ],
      ),
    );
  }
}

class AnswerBar extends StatefulWidget {
  List<bool> isSelected = [false, false, false, false];
  List<String> answers = ['A', 'B', 'C', 'D'];
  int selectedIndex = -1;

  @override
  _AnswerBarState createState() => _AnswerBarState();
}

class _AnswerBarState extends State<AnswerBar> {
  void chooseAnswer(){
    setState(() {
      widget.isSelected[widget.selectedIndex] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for(int i = 0; i < 4; i++)
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: widget.selectedIndex==i ? ColorManager.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: widget.selectedIndex==i ? ColorManager.primaryColor : Colors.black,
                  width: 1,
                ),
              ),
              child: TextButton(
                onPressed: (){
                  widget.selectedIndex = i;
                  chooseAnswer();
                },
                child: Text(
                  widget.answers[i],
                  style: getSemiBoldStyle(
                    color: widget.selectedIndex==i ? Colors.white : Colors.black,
                    fontSize: 14
                  )
                ),
              ),
            )
        ],
      )
    );
  }
}


