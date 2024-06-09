import 'package:ez_english/config/constants.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/practice/practice_page.dart';
import 'package:ez_english/presentation/main/practice/listening/listening_question_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/route_manager.dart';

class SkillPracticePage extends StatefulWidget {
  const SkillPracticePage({super.key, required this.skill});
  final String skill;
  @override
  _SkillPracticePageState createState() => _SkillPracticePageState();
}

class _SkillPracticePageState extends State<SkillPracticePage> {
  late String titleAppBar, titlePage;
  late List<PartObject> partList;
  @override
  void initState() {
    super.initState();
  }

  void initContent() {
    switch (widget.skill) {
      case "Listening":
        titleAppBar = AppLocalizations.of(context)!.listening;
        titlePage = AppLocalizations.of(context)!.listening_practice;
        partList = [
          PartObject(
              1, AppLocalizations.of(context)!.photographs, widget.skill),
          PartObject(
              2, AppLocalizations.of(context)!.question_response, widget.skill),
          PartObject(
              3, AppLocalizations.of(context)!.conversations, widget.skill),
          PartObject(4, AppLocalizations.of(context)!.talks, widget.skill),
        ];
        break;
      case "Speaking":
        titleAppBar = AppLocalizations.of(context)!.speaking;
        titlePage = AppLocalizations.of(context)!.speaking_practice;
        partList = [
          PartObject(
              1, AppLocalizations.of(context)!.read_aloud_word, widget.skill),
          PartObject(
              2, AppLocalizations.of(context)!.describe_picture, widget.skill),
          PartObject(
              3, AppLocalizations.of(context)!.pronounce_audio, widget.skill),
        ];
        break;
      case "Reading":
        titleAppBar = AppLocalizations.of(context)!.reading;
        titlePage = AppLocalizations.of(context)!.reading_practice;
        partList = [
          PartObject(5, AppLocalizations.of(context)!.incomplete_sentences,
              widget.skill),
          PartObject(
              6, AppLocalizations.of(context)!.text_completion, widget.skill),
          PartObject(7, AppLocalizations.of(context)!.reading_comprehension,
              widget.skill),
        ];
        break;
      case "Writing":
        titleAppBar = AppLocalizations.of(context)!.writing;
        titlePage = AppLocalizations.of(context)!.writing_practice;
        partList = [
          PartObject(
              1,
              AppLocalizations.of(context)!.write_sentence_based_on_picture,
              widget.skill),
          PartObject(2, AppLocalizations.of(context)!.respond_written_request,
              widget.skill),
          PartObject(3, AppLocalizations.of(context)!.write_opinion_essay,
              widget.skill),
        ];
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initContent();
    return Scaffold(
      body: Column(children: <Widget>[
        GradientAppBar(
          content: titleAppBar,
          prefixIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: SkillPageBody(
            title: titlePage,
            partList: partList,
          ),
        ),
      ]),
    );
  }
}

class SkillPageBody extends StatelessWidget {
  const SkillPageBody({super.key, required this.title, required this.partList});
  final String title;
  final List<PartObject> partList;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: getSemiBoldStyle(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(height: 9),
                Text(
                  AppLocalizations.of(context)!.choose_once_to_begin,
                  style: getSemiBoldStyle(
                      color: ColorManager.lightTextColor, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: partList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SkillPracticeItem(part: partList[index]);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ]);
  }
}

class SkillPracticeItem extends StatelessWidget {
  final PartObject part;
  const SkillPracticeItem({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        switch (part.skill) {
          case "Listening":
          case "Reading":
          case "Speaking":
            Navigator.pushNamed(context, RoutesName.partInfoRoute,
                arguments: [true, part]);
          case "Writing":
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: <Widget>[
                Container(
                  width: 47,
                  height: 47,
                  decoration: const BoxDecoration(
                    color: ColorManager.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      part.index.toString(),
                      style: getSemiBoldStyle(
                          color: ColorManager.primaryColor, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: width * 0.7,
                        child: Text(
                          part.title,
                          style: getSemiBoldStyle(
                                  color: Colors.black, fontSize: 12)
                              .copyWith(overflow: TextOverflow.clip),
                        ),
                      ),
                    ])
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
