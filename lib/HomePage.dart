import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String userName;
  // String userLevel;

  // _HomePageState(this.userName, this.userLevel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HomePageAppBar(),
          Expanded(
            child: HomePageBody(),
          ),  
        ]
      ),
      bottomNavigationBar: HomePageBottomNavigationBar(),
    );
  }
}

class HomePageAppBar extends StatefulWidget {
  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF89B8C2),
            Color(0xFF2E8094)
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 66),
          Row(
            children: <Widget>[
              const SizedBox(width: 28),
              // ClipOval(
              //   child: Image // hình ảnh
              //   width: 62,     Định dùng này làm icon thay container
              //   height: 62,
              //   fit: BoxFit.cover,
              //   ),
              Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  //Icon
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'userName',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    'userLevel',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ]
              )
            ]
          ),
        ]
      ),
    );
  }
}    

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TipList(),
        Container(
          width: 393,
          padding: const EdgeInsets.only(left: 36),
          child: const Text(
            'Continue where you left off',
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 36,
            ),
            Expanded(
              child: HistoryList()
            )
          ],
        )
      ]
    );
  }
}

class Tip extends StatelessWidget {
  final String content;

  Tip(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFF0000),
      ),
      child: Center(child: Text(content))
    );
  }
}

class TipList extends StatefulWidget {
  final List<String> tips = [
    'Tip 1',
    'Tip 2',
    'Tip 3',
  ];

  TipList();

  @override
  _TipListState createState() => _TipListState();
}

class _TipListState extends State<TipList> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 105,
          width: 329,
          child: PageView(
            controller: _controller,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[
              for (var tip in widget.tips) Tip(tip)
            ]
          )
        ),
        SizedBox(
          height: 44,
          child: Center(
            child: Container(
              height: 24,
              width: 24*widget.tips.length.toDouble(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xFFD9D9D9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for(var index = 0; index < widget.tips.length; index++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? 
                          const Color(0xFF000000) : const Color(0xFFBFBFBF)
                      ),
                    ),
                ]
              ),
            ),
          )
        )
      ],
    );
  } 
}  

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final List<String> items = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (var item in items) Activity(),
        ],
      ),
    );
  }
}

class Activity extends StatelessWidget {
  //final String skill;
  //final String chapter;

  //Activity(this.skill, this.chapter);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 264,
        width: 190,
        padding: const EdgeInsets.only(left: 23, top: 29),
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFD6F0FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'skill',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black, 
                fontFamily: 'Poppins'
              ),
            ),
            Text(
              'chapter',
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w300,
                color: Colors.black, 
                fontFamily: 'Poppins'
              ),
            ),
          ]
        )
      )
    );
  }
}


class HomePageBottomNavigationBar extends StatefulWidget {
  @override
  _HomePageBottomNavigationBarState createState() => _HomePageBottomNavigationBarState();
}

class _HomePageBottomNavigationBarState extends State<HomePageBottomNavigationBar> {
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
            BottomNavigationBarChosenItem(Icons.home, 'Home', 0),
            BottomNavigationBarItem(Icons.home, 'Practice', 1),
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