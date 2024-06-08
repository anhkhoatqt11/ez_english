import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';

import 'package:ez_english/presentation/main/home/banner.dart';
import 'package:ez_english/presentation/main/home/history.dart';
import 'package:ez_english/presentation/main/home/tip/tip.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

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
    final uuid = supabase.auth.currentUser!.id;

    return Scaffold(
      body: Column(
        children: <Widget>[
          HomePageAppBar(uuid),
          Expanded(
            child: HomePageBody(uuid),
          ),  
        ]
      )
    );
  }
}

class HomePageAppBar extends StatefulWidget {
  final String uuid;
  const HomePageAppBar(this.uuid);
  @override
  _HomePageAppBarState createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {  
  late String userLevel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: supabase.from("profiles").select().eq("uuid", widget.uuid).single(), 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final userInfor = snapshot.data!;
        switch (userInfor['level_id']) {
          case 1:
            userLevel = "Beginner";
            break;
          case 3:
            userLevel = "Intermediate";
            break;
          case 4:
            userLevel = "Advanced";
            break;
        }
        return Container(
          height: 154,
          decoration: const BoxDecoration(
            gradient: ColorManager.linearGradientPrimary,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 66),
              Row(
                children: <Widget>[
                  const SizedBox(width: 28),
                  SizedBox(
                    width: 62,
                    height: 62,
                    child: ClipOval(
                      child: Image.network(
                        userInfor['avatar_url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userInfor['full_name'],
                        style: getSemiBoldStyle(color: Colors.white, fontSize: 20)
                      ),
                      Text(
                        userLevel,
                        style: getRegularStyle(color: Colors.white, fontSize: 14)
                      ),
                    ]
                  )
                ]
              ),
            ]
          ),
        );
      }
    );
  }
}    

class HomePageBody extends StatefulWidget {
  final String uuid;

  const HomePageBody(this.uuid);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 30),
        BannerList(),
        Container(
          width: 393,
          padding: const EdgeInsets.only(left: 36),
          child: Text(
            AppLocalizations.of(context)!.continue_where_you_left_off,
            style: getSemiBoldStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 36,
            ),
            Expanded(
              child: HistoryList(widget.uuid),
            )
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: 393,
          padding: const EdgeInsets.only(left: 36),
          child: Row(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.english_tips,
                style: getSemiBoldStyle(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.newTipRoute);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    gradient: ColorManager.linearGradientPrimary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        TipList(),
      ]
    );
  }
}