import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/presentation/common/widgets/stateful/app_bottom_navigation_bar.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';

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
    final uuid = supabase.auth.currentUser?.id;

    return Scaffold(
      body: Column(
        children: <Widget>[
          HomePageAppBar(uuid!),
          Expanded(
            child: HomePageBody(uuid),
          ),  
        ]
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        pageController: PageController(
          initialPage: 0,
        ),
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
    final _future = supabase.from("profiles").select().eq("uuid", widget.uuid).single();

    return FutureBuilder(
      future: _future, 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final userInfor = snapshot.data!;
        switch (userInfor['level_id']) {
          case 0:
            userLevel = "Beginner";
            break;
          case 1:
            userLevel = "Intermediate";
            break;
          case 2:
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
        )
      ]
    );
  }
}

class BannerItem extends StatelessWidget {
  final String mediaUrl;

  BannerItem({required this.mediaUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        mediaUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class BannerList extends StatefulWidget {

  BannerList();

  @override
  _BannerListState createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  
  final PageController _controller = PageController();
  int _currentPage = 0;
  final _future = supabase.from("banners").select("media_url");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final banners = snapshot.data!;
        return Column(
          children: [
            SizedBox(
              height: 105,
              width: 329,
              child: PageView(
                controller: _controller,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  for (var banner in banners)
                    BannerItem(mediaUrl: banner['media_url'])
                ]
              )
            ),
            SizedBox(
              height: 44,
              child: Center(
                child: Container(
                  height: 24,
                  width: 24*banners.length.toDouble(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ColorManager.indicatorColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for(var index = 0; index < banners.length; index++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index ? 
                              Colors.black : ColorManager.indicatorDotColor,
                          ),
                        ),
                    ]
                  ),
                ),
              )
            )
          ],
        );
      }
    );
  } 
}  

class HistoryList extends StatefulWidget {
  final String uuid;

  const HistoryList(this.uuid);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {

  @override
  Widget build(BuildContext context) {
    final _future = supabase.from("history").select().eq("by_uuid", widget.uuid);

    return FutureBuilder(
      future: _future,
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
            Navigator.pushNamed(context, RoutesName.writingQuestionRoute,
                arguments: part);
            break;
        }
      },
      child: Container(
        height: 264,
        width: 190,
        padding: const EdgeInsets.only(left: 23, top: 29),
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
            Text(
              'Part $part',
              style: getLightStyle(color: Colors.black, fontSize: 14)
            ),
          ]
        )
      )
    );
  }
}