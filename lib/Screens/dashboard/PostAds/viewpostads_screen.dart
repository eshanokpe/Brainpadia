import 'package:flutter/material.dart';
import 'package:brainepadia/Screens/dashboard/PostAds/addpostads_screen.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/P2PPostAdsProvider.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'editSellPostads.dart';
import 'viewPostAds/viewbuypostads_screen.dart';
import 'viewPostAds/viewsellpostads_screen.dart';

class PostAds extends StatefulWidget {
  final int
      initialTabIndex; // Define a property to receive the initial tab index
  const PostAds({Key? key, required this.initialTabIndex}) : super(key: key);

  @override
  _PostAdsState createState() => _PostAdsState();
}

class _PostAdsState extends State<PostAds> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex:
            widget.initialTabIndex); // Use the received initialTabIndex

    final p2pBuyAdsProvider =
        Provider.of<P2PPostAdsProvider>(context, listen: false);
    p2pBuyAdsProvider.fetchP2PUserBuyAds();
    p2pBuyAdsProvider.fetchP2PUserSellAds();
  }

  Future<void> _refresh() async {
    final p2pBuyAdsProvider =
        Provider.of<P2PPostAdsProvider>(context, listen: false);
    p2pBuyAdsProvider.fetchP2PUserBuyAds();
    p2pBuyAdsProvider.fetchP2PUserSellAds();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          title: const Text(
            'My Ads',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AddPostAds();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 20, right: 20),
                labelColor: kPrimaryBlack,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                tabs: const [Tab(text: 'Buy'), Tab(text: 'Sell')],
              ),
            ),
            Expanded(
              // Use Expanded to occupy remaining space
              child: TabBarView(
                controller: _tabController,
                children: const [ViewBuyPostAds(), ViewSellPostAds()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint _paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
