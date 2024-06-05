import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';

class HistoryList extends StatefulWidget {
  final String uuid;

  const HistoryList(this.uuid);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: supabase.from("history").select().eq("by_uuid", widget.uuid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final activities = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (var activity in activities)
                Activity(
                  activity['skill'],
                  activity['part']
                )
            ],
          ),
        );
      }
    );
  }
}

class Activity extends StatelessWidget {
  final String skill;
  final int part;

  Activity(this.skill, this.part);

  @override
  Widget build(BuildContext context) {
    Icon icon;

    if (skill == "Listening")
    {
      icon = const Icon(Icons.volume_up_sharp);
    }
    else if (skill == "Reading")
    {
      icon = const Icon(Icons.book);
    }
    else if (skill == "Speaking")
    {
      icon = const Icon(Icons.mic);
    }
    else if (skill == "Writing")
    {
      icon = const Icon(Icons.edit);
    } 
    else 
    {
      icon = const Icon(Icons.help);
    }

    return InkWell(
      onTap: () {
        switch (skill) {
          case "Listening":
            Navigator.pushNamed(context, RoutesName.listeningQuestionRoute,
                arguments: part);
            break;
          case "Reading":
            Navigator.pushNamed(context, RoutesName.readingQuestionRoute,
                arguments: part);
            break;
          case "Speaking":
            Navigator.pushNamed(context, RoutesName.speakingQuestionRoute,
                arguments: part);
            break;
          case "Writing":
            break;
        }
      },
      child: Container(
        height: 100,
        width: 200,
        padding: const EdgeInsets.only(left: 15, top: 20),
        margin: const EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
          color: ColorManager.activityColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skill,
              style: getSemiBoldStyle(color: Colors.black, fontSize: 14)
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget> [
                icon,
                const SizedBox(width: 3),
                Text(
                  'Part $part',
                  style: getLightStyle(color: Colors.black, fontSize: 14)
                ),
              ]
            )
          ]
        )
      )
    );
  }
}