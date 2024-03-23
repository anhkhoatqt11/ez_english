import 'package:flutter/material.dart';

class ListeningQuestionPage extends StatefulWidget {
  @override
  _ListeningQuestionPageState createState() => _ListeningQuestionPageState();
}

class _ListeningQuestionPageState extends State<ListeningQuestionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListeningQuestionPageAppBar(),
          Expanded(
            child: ListeningQuestionPageBody(),
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
            gradient: LinearGradient(
              colors: [
                Color(0xFF89B8C2),
                Color(0xFF2E8094)
              ],
            ),
          ),
          child: const Column(
            children: <Widget>[ 
              SizedBox(height: 60),
              Text(
                'Photograph',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins'
                ),
              ),
            ],
          ),     
        ),
        Positioned(
          top: 63,
          left: 34,
          child: GestureDetector(
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
  @override
  _ListeningQuestionPageBodyState createState() => _ListeningQuestionPageBodyState();
}

class _ListeningQuestionPageBodyState extends State<ListeningQuestionPageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 67),
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
          child: const Text(
            'Question 1',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
          ),
        ),
        const SizedBox(height: 32),
        AnswerBar(),
        const SizedBox(height: 32),
        NextButton(),
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
        color: const Color(0xFF89B8C2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 23),
          IconButton(
            onPressed: (){}, 
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            )
          ),
          const SizedBox(width: 34.91),
          IconButton(
            onPressed: (){}, 
            color: Colors.white,
            icon: const Icon(
              Icons.pause,
              size: 18,
            )
          ),
          const SizedBox(width: 34.91),
          IconButton(
            onPressed: (){}, 
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            )
          ),
          const SizedBox(width: 32.91),
          Text(
            '00:00',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
          ),
          const SizedBox(width: 4),
          Slider(
            value: widget._value,
            min: 0.0,
            max: 100.0,
            onChanged: (value) {
              changeValue(value);
            },
            activeColor: const Color(0xFF126E85), 
            inactiveColor: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            '00:00',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
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
                color: widget.selectedIndex==i ? const Color(0xFF126E85) : Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: widget.selectedIndex==i ? const Color(0xFF126E85) : Colors.black,
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
                  style: TextStyle(
                    color: widget.selectedIndex==i ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            )
        ],
      )
    );
  }
}

class NextButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF126E85),
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF74C9DC),
            Color(0xFF126E85)
          ]
        )
      ),
      child: TextButton(
        onPressed: (){},
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
