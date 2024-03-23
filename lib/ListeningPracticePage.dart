import 'package:flutter/material.dart';

class ListeningPage extends StatefulWidget {
  @override
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListeningPageAppBar(),
          Expanded(
            child: ListeningPageBody(),
          ),  
        ]
      ),
    );
  }
}

class ListeningPageAppBar extends StatefulWidget {
  @override
  _ListeningPageAppBarState createState() => _ListeningPageAppBarState();
}

class _ListeningPageAppBarState extends State<ListeningPageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF89B8C2),
            Color(0xFF2E8094)
          ],
        ),
      ),
      padding: const EdgeInsets.only(top: 63, left: 34),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
          ),
          const SizedBox(width: 12.91),
          const Text(
            'Listening', style : TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
          ),
        ],
      )
    );
  }
}

class ListeningPageBody extends StatefulWidget {
  @override
  _ListeningPageBodyState createState() => _ListeningPageBodyState();
}

class _ListeningPageBodyState extends State<ListeningPageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 39),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                'Listening Practice',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.black
                ),
              ),
              SizedBox(height: 9),
              Text(
                'Choose once to begin',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xFFD9D9D9)
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        ListeningPracticeList(),
      ]
    );
  }
}

class ListeningPracticeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListeningPracticeItem('Listening Practice 1'),
        ListeningPracticeItem('Listening Practice 2'),
        ListeningPracticeItem('Listening Practice 3'),
        ListeningPracticeItem('Listening Practice 4'),
        ListeningPracticeItem('Listening Practice 1'),
        ListeningPracticeItem('Listening Practice 2'),
        ListeningPracticeItem('Listening Practice 3'),
        ListeningPracticeItem('Listening Practice 4'),
        ListeningPracticeItem('Listening Practice 1'),
        ListeningPracticeItem('Listening Practice 2'),
        ListeningPracticeItem('Listening Practice 3'),
        ListeningPracticeItem('Listening Practice 4'),
      ],
    );
  }
}

class ListeningPracticeItem extends StatelessWidget {
  final String practiceName;

  ListeningPracticeItem(this.practiceName);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              color: Colors.grey.withOpacity(0.3), 
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
                    color: Color(0xFFD6F0FF),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'practiceType',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      'corectAnswer / totalQuestion',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ]
                )
              ]
            ),
            const SizedBox(height: 17),
            Row(
              children: <Widget>[
                const SizedBox(width: 20),
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 246,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: const Color(0xFF74C9DC), 
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      value: 0.5, 
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF126E85)), 
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
