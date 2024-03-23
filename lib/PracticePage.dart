import 'package:flutter/material.dart';

class PracticePage extends StatefulWidget {
  @override
  _PracticePageState createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          PracticePageAppBar(),
          Expanded(
            child: PracticePageBody(),
          ),  
        ]
      ),
      bottomNavigationBar: PracticePageBottomNavigationBar(),
    );
  }
}

class PracticePageAppBar extends StatefulWidget {
  @override
  _PracticePageAppBarState createState() => _PracticePageAppBarState();
}

class _PracticePageAppBarState extends State<PracticePageAppBar> {
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
      child: Container(
        padding: const EdgeInsets.only(top: 63),
        alignment: Alignment.center,
        child: const Text(
          'Practice', style : TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Poppins'
          ),
        ),  
      ),
    );
  }
}

class PracticePageBody extends StatefulWidget {
  @override
  _PracticePageBodyState createState() => _PracticePageBodyState();
}

class _PracticePageBodyState extends State<PracticePageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 149,
          padding: const EdgeInsets.only(left: 27, top: 20),
          child: const Text(
            'Choose a skill to practice',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14, 
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
          ),
        ),
        PracticeList(
          practiceItem: [
            PracticeItem('Listening'),
            PracticeItem('Speaking'),
            PracticeItem('Reading'),
            PracticeItem('Writing')
          ],
        ),
        
      ]
    );
  }
}

class PracticeList extends StatefulWidget {
  final List<PracticeItem> practiceItem;

  PracticeList({required this.practiceItem});

  @override
  _PracticeListState createState() => _PracticeListState();
}

class _PracticeListState extends State<PracticeList> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(                 // PageView
          height: 387,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.practiceItem.length,
            itemBuilder: (context, index) {
              return widget.practiceItem[index].build();
            },
            onPageChanged: (int index) {
              setState(
                () {
                  _currentPage = index;
                }
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(                     // Page Indicator
          height: 44,
          child: Center(
            child: Container(
              height: 24,
              width: 24*widget.practiceItem.length.toDouble(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xFFD9D9D9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.practiceItem.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? 
                        const Color(0xFF000000) : const Color(0xFFBFBFBF)
                    ),
                  ),
                ),
              ),
            )
          )
        )
      ],
    );
  } 
} 

class PracticeItem{
  final String title;

  PracticeItem(this.title);

  Widget build() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 180,
            width: 204,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 86,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF72C7DB),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            'Train your $title skill by our tests',
            style: const TextStyle(
              color: Color(0xFFD9D9D9),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StartButton(),
        ]
      ),  
    );
  }
}

class StartButton extends StatelessWidget {

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
          'Start',
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

class PracticePageBottomNavigationBar extends StatefulWidget {
  @override
  _PracticePageBottomNavigationBarState createState() => _PracticePageBottomNavigationBarState();
}

class _PracticePageBottomNavigationBarState extends State<PracticePageBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(top: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BottomNavigationBarItem(Icons.home, 'Home', 0),
            BottomNavigationBarChosenItem(Icons.home, 'Practice', 1),
            BottomNavigationBarItem(Icons.home, 'Test', 2),
            BottomNavigationBarItem(Icons.home, 'Profile', 3),
          ],
        )
      ),
    );
  }

  Widget BottomNavigationBarChosenItem(IconData iconData, String iconText, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Container(
        width: 125,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF126E85),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, color: Colors.white),
            const SizedBox(width: 10),
            Text(iconText, style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget BottomNavigationBarItem(IconData iconData, String text, int index) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: Icon(iconData, color: const Color(0xFF126E85)),
    );
  }
}