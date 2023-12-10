import 'package:brainepadia/Screens/dashboard/PostAds/editSellPostads.dart';
import 'package:brainepadia/Screens/dashboard/profile/components/profile_component.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/P2PPostAdsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyDetailsPostAds extends StatelessWidget {
  final int p2PBuyAdsId;
  const BuyDetailsPostAds({super.key, required this.p2PBuyAdsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: 'Buy Details'),
    );
  }
}
