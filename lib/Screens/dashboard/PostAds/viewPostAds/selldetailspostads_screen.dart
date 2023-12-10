import 'package:brainepadia/Screens/dashboard/profile/components/profile_component.dart';

import 'package:flutter/material.dart';

class SellDetailsPostAds extends StatelessWidget {
  final int p2PBuyAdsId;
  const SellDetailsPostAds({super.key, required this.p2PBuyAdsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: 'Sell Details'),
    );
  }
}
