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
  late Future<List<Map<String, dynamic>>> testFuture;

  @override
  void initState() {
    super.initState();
    testFuture = getTest();
  }

  Future<List<Map<String, dynamic>>> getTest() async {
    return await supabase.from("test").select();
  }

  String getTestName(int testId, List<Map<String, dynamic>> test) {
    for (var t in test) {
      if (t['id'] == testId) {
        return t['name'];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: supabase
              .from("history")
              .select()
              .eq('by_uuid', widget.uuid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final activities = snapshot.data!;
        return FutureBuilder(
          future: testFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final testItems = snapshot.data!;
            return SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  for (var activity in activities)
                    Activity(
                      getTestName(activity['test_id'], testItems),
                      activity['score'],
                      activity['is_complete']
                    )
                ],
              ),
            );
          }
        );
      }
    );
  }
}

class Activity extends StatelessWidget {
  final String testName;
  final int score;
  final bool isComplete;

  const Activity(this.testName, this.score, this.isComplete);
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
            testName,
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          isComplete ?
          Text(
            '$score / 990',
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