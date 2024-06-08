import 'dart:async';

import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/profile/widgets/progess_appbar.dart';
import 'package:ez_english/presentation/main/profile/widgets/skill_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late final StreamSubscription<AuthState> authStateSubscription;
  late Session currentSession;

  String? fullName;
  String? avatarUrl;
  String? levelName;
  int? listeningPoint;
  int? readingPoint;
  int? speakingPoint;
  int? writingPoint;
  int? levelId;
  bool isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      final uuid = user.id;

      try {
        final profileResponse =
            await supabase.from('profiles').select().eq('uuid', uuid).single();

        setState(() {
          fullName = profileResponse['full_name'];
          avatarUrl = profileResponse['avatar_url'];
          levelId = profileResponse['level_id'];
        });

        await fetchLevelName(levelId!);

        final progressResponse = await supabase
            .from('level_progress')
            .select()
            .eq('uuid', uuid)
            .single();

        setState(() {
          listeningPoint = progressResponse['listening_point'];
          readingPoint = progressResponse['reading_point'];
          speakingPoint = progressResponse['speaking_point'];
          writingPoint = progressResponse['writing_point'];
        });

        authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
          final session = data.session;
          currentSession = session!;
        });
      } catch (error) {
        // Handle error
        print(error);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> fetchLevelName(int levelId) async {
    final levelResponse =
        await supabase.from('level').select().eq('level_id', levelId).single();

    setState(() {
      levelName = levelResponse['level_name'];
    });
  }

  Future<void> upgradeLevel() async {
    int newLevelId = 0;
    if (levelId == 1 &&
        listeningPoint! >= 500 &&
        readingPoint! >= 500 &&
        speakingPoint! >= 500 &&
        writingPoint! >= 500) {
      newLevelId = 3;
    } else if (levelId == 3 &&
        listeningPoint! >= 1000 &&
        readingPoint! >= 1000 &&
        speakingPoint! >= 1000 &&
        writingPoint! >= 1000) {
      newLevelId = 4;
    }

    if (newLevelId != 0) {
      bool confirm = await _showUpgradeDialog(context, newLevelId);
      if (confirm) {
        await supabase.from('profiles').update({'level_id': newLevelId}).eq(
            'uuid', supabase.auth.currentUser!.id);
        await fetchLevelName(newLevelId);
        setState(() {
          levelId = newLevelId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)?.upgrade_success ??
                  'Level upgraded successfully!')),
        );
      }
    }
  }

  Future<bool> _showUpgradeDialog(BuildContext context, int newLevelId) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)?.upgrade_level ??
                  'Upgrade Level'),
              content: Text(AppLocalizations.of(context)?.confirm_upgrade ??
                  'Are you sure you want to upgrade to level $newLevelId?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child:
                      Text(AppLocalizations.of(context)?.confirm ?? 'Confirm'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  void dispose() {
    authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool canUpgrade = (levelId == 1 &&
            listeningPoint != null &&
            listeningPoint! >= 500 &&
            readingPoint != null &&
            readingPoint! >= 500 &&
            speakingPoint != null &&
            speakingPoint! >= 500 &&
            writingPoint != null &&
            writingPoint! >= 500) ||
        (levelId == 3 &&
            listeningPoint != null &&
            listeningPoint! >= 1000 &&
            readingPoint != null &&
            readingPoint! >= 1000 &&
            speakingPoint != null &&
            speakingPoint! >= 1000 &&
            writingPoint != null &&
            writingPoint! >= 1000);

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ProgressAppBar(
                  content: AppLocalizations.of(context)!.progress,
                  prefixIcon: InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  userImage: avatarUrl != null
                      ? Image.network(
                          avatarUrl!,
                          width: 100,
                          height: 100,
                        )
                      : const SizedBox.shrink(),
                  suffixIcon: InkWell(
                    child: const Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                    onTap: () {
                      _showDialog(context);
                    },
                  ),
                  userName: fullName ?? 'Loading...',
                  userTitle: levelName ?? 'Loading...',
                  progress: 1,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        UserStats(
                          listening: listeningPoint ?? 0,
                          reading: readingPoint ?? 0,
                          writing: writingPoint ?? 0,
                          speaking: speakingPoint ?? 0,
                        ),
                        if (canUpgrade)
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CommonButton(
                              text: AppLocalizations.of(context)!.upgrade_level,
                              action: upgradeLevel,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)?.about_progress ?? ''),
            content: Text(
                AppLocalizations.of(context)?.about_progress_description ?? ''),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)?.got_it ?? ''),
              ),
            ],
          );
        });
  }
}
