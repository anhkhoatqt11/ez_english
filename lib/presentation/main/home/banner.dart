import 'package:ez_english/config/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/main.dart';

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