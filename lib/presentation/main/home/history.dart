import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryList extends StatefulWidget {
  final String uuid;

  const HistoryList(this.uuid);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late List<Map<String, dynamic>> testResponse;

  Future<void> getTest() async {
    final testResponse = await supabase.from("test").select();
  }

  Map<String, int> testNameAndScore(int test_id) {
    for (var test in testResponse) {
      if (test['test_id'] == test_id) {
        return {
          'test_name': test['test_name'],
          'score': test['score']
        };
      }
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    getTest();
    return FutureBuilder(
      future: supabase.
              from("history").
              select().
              eq('by_uuid', widget.uuid),
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
                  testNameAndScore(activity['test_id']),
                  activity['score'],
                  activity['is_complete']
                )
            ],
          ),
        );
      }
    );
  }
}

class Activity extends StatelessWidget {
  final Map<String, dynamic> test;
  final int score;
  final bool isComplete;

  const Activity(this.test, this.score, this.isComplete);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
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
            test['test_name'],
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          isComplete ?
          Text(
            '$score / ${test['score']}',
            style: getSemiBoldStyle(color: Colors.black, fontSize: 10)
          ) :
          Text(
            AppLocalizations.of(context)!.incomplete,
            style: getSemiBoldStyle(color: Colors.black, fontSize: 10)
          )
        ]
      )
    );
  }
}