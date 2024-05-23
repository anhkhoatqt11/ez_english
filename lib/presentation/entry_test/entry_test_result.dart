import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/utils/route_manager.dart';

class EntryTestResultPage extends StatefulWidget {
  const EntryTestResultPage({super.key, required this.level});
  final String level;

  @override
  State<EntryTestResultPage> createState() => _EntryTestResultPageState();
}

class _EntryTestResultPageState extends State<EntryTestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.entry_test_result),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset('assets/images/Saly-22.png',
                    width: 150, height: 200, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              Text(
                '${AppLocalizations.of(context)!.your_level} ${widget.level}',
                style: getBoldStyle(color: Colors.black),
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.ok),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RoutesName.mainRoute);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
