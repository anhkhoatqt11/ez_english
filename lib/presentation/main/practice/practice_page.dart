import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateful/app_bottom_navigation_bar.dart';

import '../../../utils/route_manager.dart';

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
        children: [
          GradientAppBar(
            content: AppLocalizations.of(context)!.practice,
          ),
          const Expanded(child: PracticePageBody()),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}

class PracticePageBody extends StatelessWidget {
  const PracticePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Container(
        height: 50,
        padding: const EdgeInsets.only(left: 27),
        child: Text(
          AppLocalizations.of(context)!.choose_a_skill_to_pratice,
          style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      PracticeList(
        practiceItem: [
          PracticeItem(0, AppLocalizations.of(context)!.listening,
              ImagePath.listeningSkillsPath),
          PracticeItem(1, AppLocalizations.of(context)!.speaking,
              ImagePath.speakingSkillsPath),
          PracticeItem(2, AppLocalizations.of(context)!.reading,
              ImagePath.readingSkillsPath),
          PracticeItem(3, AppLocalizations.of(context)!.writing,
              ImagePath.writingSkillsPath),
        ],
      ),
    ]);
  }
}

class PracticeList extends StatefulWidget {
  final List<PracticeItem> practiceItem;

  const PracticeList({super.key, required this.practiceItem});

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
        SizedBox(
          width: double.infinity,
          height: 380,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.practiceItem.length,
            itemBuilder: (context, index) {
              return widget.practiceItem[index];
            },
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        Center(
            child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: ColorManager.indicatorColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.practiceItem.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.black
                        : ColorManager.indicatorDotColor),
              ),
            ),
          ),
        ))
      ],
    );
  }
}

class PracticeItem extends StatelessWidget {
  final int index;
  final String title;
  final String imagePath;

  const PracticeItem(this.index, this.title, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    String trainNote = AppLocalizations.of(context)!.train_your +
        title +
        AppLocalizations.of(context)!.skill_by_our_tests;

    return Column(children: <Widget>[
      Image.asset(
        imagePath,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        title,
        style: getSemiBoldStyle(
            color: ColorManager.primaryTextColor, fontSize: 24),
      ),
      const SizedBox(
        height: 9,
      ),
      Text(trainNote,
          style: getRegularStyle(
              color: ColorManager.lightTextColor, fontSize: 14)),
      const SizedBox(
        height: 20,
      ),
      FractionallySizedBox(
        widthFactor: 0.8,
        child: CommonButton(
          text: AppLocalizations.of(context)!.start,
          action: () {
            Navigator.pushNamed(context, RoutesName.skillPracticeRoute,
                arguments: skillList[index]);
          },
        ),
      ),
    ]);
  }
}
