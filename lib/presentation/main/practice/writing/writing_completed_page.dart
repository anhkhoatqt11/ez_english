import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/main.dart';

class WritingCompletePage extends StatefulWidget {
  const WritingCompletePage({super.key});

  @override
  State<WritingCompletePage> createState() => _WritingCompletePageState();
}

class _WritingCompletePageState extends State<WritingCompletePage> {
  Future<void> upsertLevelProgress() async {
    final response = await supabase
        .from("level_progress")
        .select()
        .eq("uuid", supabase.auth.currentUser!.id);
    if (response.isNotEmpty) {
      await supabase
          .from('level_progress')
          .update({"writing_point": response[0]["writing_point"] + 50}).eq(
              "uuid", supabase.auth.currentUser!.id);
    } else {
      await supabase
          .from("level_progress")
          .insert({"uuid": supabase.auth.currentUser!.id});
    }
  }

  @override
  void initState() {
    super.initState();
    upsertLevelProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          GradientAppBar(
            content: AppLocalizations.of(context)!.writing,
            prefixIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Saly-22.png",
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.you_have_completed,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonButton(
                          text: AppLocalizations.of(context)!.ok,
                          action: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesName.mainRoute,
                              (route) =>
                                  route.settings.name != RoutesName.mainRoute,
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
