import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        ),
        const SizedBox(height: 16),
        Container(
          width: 393,
          padding: const EdgeInsets.only(left: 36),
          child: Row(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.english_tips_shouldnt_miss,
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: supabase.from("banners").select("media_url"),
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

class TipList extends StatefulWidget {
  @override
  _TipListState createState() => _TipListState();
}

class _TipListState extends State<TipList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: supabase.from("tip").select(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final tipItems = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              for (var tipItem in tipItems)
                TipItem(
                  tipItem['tip_id'],
                  tipItem['title'],
                  tipItem['content'],
                  tipItem['likes'],
                  tipItem['views'],
                  tipItem['created_at'],
                  tipItem['created_by']
                )
            ],
          ),
        );
      }
    );
  }
}

class TipItem extends StatefulWidget {
  final uuid = supabase.auth.currentUser!.id;
  final int tip_id;
  final String title;
  final String content;
  int likes;
  int views;
  final String created_at;
  final String created_by;
  late bool isLiked;
  late bool isViewed;

  TipItem(this.tip_id, 
          this.title, 
          this.content, 
          this.likes, 
          this.views, 
          this.created_at, 
          this.created_by);

  @override
  _TipItemState createState() => _TipItemState();
}

class _TipItemState extends State<TipItem> {
  @override
  void initState() {
    super.initState();
    initUserTip();
  }

  Icon heartIcon = const Icon(
    Icons.favorite_border,
    color: Colors.grey,
  );

  Future<void> initUserTip() async {
    final response = 
      await supabase.
      from('user_tip').
      select().
      match({'uuid': widget.uuid, 'tip_id': widget.tip_id}).
      maybeSingle();

    if (response == null){
      await supabase.
      from('user_tip').
      insert({
        'uuid': widget.uuid, 
        'tip_id': widget.tip_id, 
        'isliked': false, 
        'isviewed': false
      });
    } else {
      widget.isLiked = response['isliked'];
      widget.isViewed = response['isviewed'];
      if (widget.isLiked) {
        heartIcon = const Icon(
          Icons.favorite,
          color: Colors.red,
        );
      }
    }
  }
  
  bool isUpdatingLike = false;

  Future<void> updateLike() async {
    if (isUpdatingLike) return; 
    
    isUpdatingLike = true; 
      
    final tipUpdateFuture = 
    supabase.
    from("tip").
    update({"likes": widget.likes}).
    eq("tip_id", widget.tip_id);

    final userTipUpdateFuture = 
    supabase.
    from("user_tip").
    update({"isliked": widget.isLiked}).
    match({'uuid': widget.uuid, 'tip_id': widget.tip_id});

    await Future.wait([tipUpdateFuture, userTipUpdateFuture]);

    isUpdatingLike = false; 
  }


  Future<void> updateView() async {
    if (widget.isViewed == false) {
      await supabase.
      from("tip").
      update({"views": widget.views + 1}).
      eq("tip_id", widget.tip_id);

      await supabase.
      from("user_tip").
      update({"isviewed": true}).
      match({'uuid': widget.uuid, 'tip_id': widget.tip_id});
    }
  }


  String calculateDateRange(String create_at) {
    DateTime now = DateTime.now();
    DateTime createAt = DateTime.parse(create_at);
    Duration difference = now.difference(createAt);

    if (difference.inDays > 0) {
      return "${difference.inDays} ${AppLocalizations.of(context)!.d_ago}";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} ${AppLocalizations.of(context)!.h_ago}";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} ${AppLocalizations.of(context)!.m_ago}";
    } else {
      return AppLocalizations.of(context)!.just_now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: supabase.from("profiles").select().eq("uuid", widget.created_by).single(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final userTips = snapshot.data!;
        
        return InkWell(
          onTap: () async {
            await updateView();

            Navigator.pushNamed(context, RoutesName.tipDetailRoute,
              arguments: {
                'title': widget.title,
                'content': widget.content
              }
            );
          },
          child: Container(
            height: 200,
            padding: const EdgeInsets.only(left: 30, top: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: ClipOval(
                        child: Image.network(
                          userTips['avatar_url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            text: userTips['full_name'],
                            style: getLightStyle(color: Colors.black, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                text: '  ${calculateDateRange(widget.created_at)}',
                                style: getLightStyle(color: Colors.grey, fontSize: 12)
                              )
                            ]
                          )
                        ),
                      ]
                    )
                  ]
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: getLightStyle(color: Colors.black, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.content,
                  style: getLightStyle(color: Colors.black, fontSize: 12),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {      
                        setState(() {
                          if (widget.isLiked) {
                            heartIcon = const Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                            );
                            widget.likes -= 1;
                            widget.isLiked = false;
                          } else {
                            heartIcon = const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            );
                            widget.likes += 1;
                            widget.isLiked = true;
                          }
                        });
               
                        updateLike();
                      },
                      child: heartIcon,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.likes}",
                      style: getLightStyle(color: Colors.grey, fontSize: 12)
                    ),
                  ]
                )
              ],
            )
          )  
        );
      }
    );
  }
}