import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EntryTestIntroductionPage extends StatefulWidget {
  const EntryTestIntroductionPage({super.key});

  @override
  State<EntryTestIntroductionPage> createState() =>
      _EntryTestIntroductionPageState();
}

class _EntryTestIntroductionPageState extends State<EntryTestIntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.entry_test),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Image.asset('assets/images/Saly-15.png',
                  width: 150, height: 200, fit: BoxFit.cover),
            ),
            Text(AppLocalizations.of(context)!.entry_test_description_1),
            Text(AppLocalizations.of(context)!.entry_test_description_2),
            Text(AppLocalizations.of(context)!.entry_test_description_3),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                child: Text(AppLocalizations.of(context)!.start),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(RoutesName.entryTestRoute);
                }),
          ),
        ),
      ]),
    );
  }
}
