import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          AppLocalizations.of(context)!.practice,
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
          height: 129,
          padding: const EdgeInsets.only(left: 27),
          child: Text(
            AppLocalizations.of(context)!.choose_a_skill_to_pratice,
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        PracticeList(
          practiceItem: [
            PracticeItem(AppLocalizations.of(context)!.listening),
            PracticeItem(AppLocalizations.of(context)!.speaking),
            PracticeItem(AppLocalizations.of(context)!.reading),
            PracticeItem(AppLocalizations.of(context)!.writing),
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
        Container(                 // PageView
          height: 463,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.practiceItem.length,
            itemBuilder: (context, index) {
              return widget.practiceItem[index].build(context);
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
        Container(                     // Page Indicator
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

class PracticeItem extends StatelessWidget{
  final String title;

  PracticeItem(this.title);

  Widget build(BuildContext context) {
    String trainNote = AppLocalizations.of(context)!.train_your + title + AppLocalizations.of(context)!.skill_by_our_tests;

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
            trainNote,
            style: getRegularStyle(color: ColorManager.lightTextColor, fontSize: 14)
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: 309,
              child: CommonButton(text: AppLocalizations.of(context)!.start),
          ),
        ]
      ),  
    );
  }
}
