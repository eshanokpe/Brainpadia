// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/postads_Buyform.dart';
import 'components/postads_Sellform.dart';

class AddPostAds extends StatefulWidget {
  const AddPostAds({Key? key}) : super(key: key);

  @override
  _AddPostAdsState createState() => _AddPostAdsState();
}

class _AddPostAdsState extends State<AddPostAds>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
     final bankDetails = Provider.of<UserProvider>(context, listen: false);
        bankDetails.fetchBankDetails();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_left,
              color: kPrimaryBlack,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Post Ads',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            controller: _tabController, // Assign the TabController here
            labelColor: kPrimaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            labelPadding: const EdgeInsets.only(left: 20, right: 20),

            tabs:const [
               Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Buy"),
                ),
              ),
               Tab(
                child:  Align(
                  alignment: Alignment.center,
                  child: Text("Sell"),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Center(child: PostadsBuyForm()),
            Center(child: PostadsSellForm()),
          ],
        ),
      ),
    );
  }
}
