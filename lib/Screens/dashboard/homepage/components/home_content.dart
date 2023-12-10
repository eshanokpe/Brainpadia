import 'package:brainepadia/Screens/dashboard/transaction/transaaction_page.dart';
import 'package:brainepadia/providers/fetchBlockchain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  final String? walletAddress;
  HomeContent({super.key, required this.walletAddress});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    final p2pBuyAdsProvider =
        Provider.of<FetchBlockchain>(context, listen: false);
    p2pBuyAdsProvider.fetchTransaction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions',
                style: TextStyle(
                  color: Color(0xff2B2D80),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllTransaction(),
                      ));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xff2B2D80),
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Consumer<FetchBlockchain>(builder: (context, transactionData, _) {
          final transactionList = transactionData.transactionData;

          if (transactionList.isEmpty) {
            if (transactionData.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child: Image.asset(
                'assets/icons/nodata.png',
                height: 120,
              ));
            }
          }
          return Center(
              child: Text(
            'assets/icons/nodata.png',
          ));
        }),
      ],
    );
  }
}
