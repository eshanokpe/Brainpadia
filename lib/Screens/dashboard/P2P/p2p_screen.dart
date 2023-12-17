import 'package:brainepadia/Screens/dashboard/P2P/components/sell_list.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/P2PPostAdsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/buy_list.dart';

class P2P extends StatefulWidget {
  const P2P({Key? key}) : super(key: key);

  @override
  _P2PState createState() => _P2PState();
}

class _P2PState extends State<P2P> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _refresh();
    _tabController = TabController(length: 2, vsync: this);
    final p2pBuyAdsProvider =
        Provider.of<P2PPostAdsProvider>(context, listen: false);
    p2pBuyAdsProvider.fetchP2PBuyAds();
    p2pBuyAdsProvider.fetchP2PSellAds();
  }

  Future<void> _refresh() async {
    final p2pBuyAdsProvider =
        Provider.of<P2PPostAdsProvider>(context, listen: false);
    p2pBuyAdsProvider.fetchP2PBuyAds();
    p2pBuyAdsProvider.fetchP2PSellAds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _refresh;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('P2P'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Buy'),
              Tab(text: 'Sell'),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 16.0),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            RefreshIndicator(
              onRefresh: _refresh,
              color: kPrimaryColor,
              child: const BuyList(),
            ),
            RefreshIndicator(
              onRefresh: _refresh,
              color: kPrimaryColor,
              child: const SellList(),
            ),
          ],
        ),
      ),
    );
  }
}
