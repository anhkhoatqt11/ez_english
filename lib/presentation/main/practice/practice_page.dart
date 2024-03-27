import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateful/app_bottom_navigation_bar.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  _PracticePageState createState() {
    return _PracticePageState();
  }
}

class _PracticePageState extends State<PracticePage> {
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
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          PracticePageAppBar(),
          Expanded(
            child: PracticePageBody(),
          ),  
        ]
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        pageController: PageController(
          initialPage: 1,
        ),
      )
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
        gradient: ColorManager.linearGradientPrimary,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 63),
        alignment: Alignment.center,
        child: Text(
          'Practice', 
          style: getSemiBoldStyle(color: Colors.white, fontSize: 14),
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
          child: Text(
            'Choose a skill to practice',
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
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
                color: ColorManager.indicatorColor,
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
                        Colors.black : ColorManager.indicatorDotColor
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
            color: Colors.red,
          ),
          const SizedBox(
            height: 86,
          ),
          Text(
            title,
            style: getSemiBoldStyle(color: ColorManager.primaryTextColor, fontSize: 24),
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            'Train your $title skill by our tests',
            style: getRegularStyle(color: ColorManager.lightTextColor, fontSize: 14)
          ),
          const SizedBox(
            height: 20,
          ),
          const CommonButton(text: 'Start'),
        ]
      ),  
    );
  }
}
