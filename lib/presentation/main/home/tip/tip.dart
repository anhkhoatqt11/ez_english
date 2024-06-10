import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:shimmer/shimmer.dart';

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
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (var i = 0; i < 5; i++)
                  ShimmerItem()
              ],
            ),
          );
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
// ShimmerItem when TipItem not load yet
class ShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
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
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey,
                    ),
                  ]
                )
              ]
            ),
            const SizedBox(height: 8),
            Container(
              width: 300,
              height: 10,
              color: Colors.grey,
            ),
            Container(
              width: 300,
              height: 10,
              color: Colors.grey,
            ),
            Container(
              width: 300,
              height: 10,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.grey,
                ),
              ]
            )
          ],
        )
      )
    );
  }
}