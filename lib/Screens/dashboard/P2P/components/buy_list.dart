import 'package:brainepadia/Screens/dashboard/PostAds/viewPostAds/buydetailspostads_screen.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/providers/P2PPostAdsProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyList extends StatelessWidget {
  const BuyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(31, 130, 130, 130),
      child: Consumer<P2PPostAdsProvider>(
        builder: (context, p2pUserSellAdsProvider, _) {
          final p2pUserSellAds = p2pUserSellAdsProvider.p2pSellAds;

          if (p2pUserSellAds.isEmpty) {
            if (p2pUserSellAdsProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child: Image.asset(
                'assets/icons/nodata.png',
                height: 120,
              ));
            }
          }

          return ListView.builder(
            itemCount: p2pUserSellAds.length,
            itemBuilder: (context, index) {
              final p2pSellAd = p2pUserSellAds.reversed.toList()[index];
              final nickName = p2pSellAd['bankDetails']['profile']['nickName'];
              final imageUrl = p2pSellAd['bankDetails']['profile']['imageUrl'];
              final bankName = p2pSellAd['bankDetails']['bankName'];
              final amount = p2pSellAd['amount'];
              final price = p2pSellAd['price'];
              final limitFrom = p2pSellAd['limitFrom'];
              final limitTo = p2pSellAd['limitTo'];
              final asset = p2pSellAd['asset'];
              final currency = p2pSellAd['currency'];
              final p2PSellAdsId = p2pSellAd['p2PBuyAdsId'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BuyDetailsPostAds(
                          p2PBuyAdsId: p2PSellAdsId,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(
                      left: 18, right: 18, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //border: Border.all(color: kPrimaryColor, width: 2.0),
                    // color: Color.fromARGB(239, 255, 181, 54),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              imageUrl == null
                                  ? const CircleAvatar(
                                      radius: 10,
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.png'),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: imageUrl!,
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                        radius: 15,
                                        backgroundImage: imageProvider,
                                      ),
                                      placeholder: (context, url) =>
                                          const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors
                                            .grey, // Placeholder background color
                                        child:
                                            CircularProgressIndicator(), // Loading indicator
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors
                                            .grey, // Placeholder background color
                                        child: Icon(Icons
                                            .error), // Error icon or widget
                                      ),
                                    ),
                              const SizedBox(width: 10),
                              Text(
                                nickName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Price:-',
                                style: TextStyle(
                                  color: palColor,
                                ),
                              ),
                              Text(
                                '$price',
                                style: const TextStyle(
                                  color: kPrimaryBlack,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text('Buy',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                )),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green),
                            width: 40,
                            height: 20,
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Limit: ',
                            style: TextStyle(

                                //fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          const SizedBox(width: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Min: ',
                                    style: TextStyle(
                                        color: Color(
                                          0xff828282,
                                        ),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    '\$${limitFrom.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match match) => '${match[1]},',
                                        )}',
                                    style: const TextStyle(
                                      color: kPrimaryBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              Row(
                                children: [
                                  const Text(
                                    'Max: ',
                                    style: TextStyle(
                                        color: Color(
                                          0xff828282,
                                        ),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    '\$${limitTo.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match match) => '${match[1]},',
                                        )}',
                                    style: const TextStyle(
                                      color: kPrimaryBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Asset: ',
                              ),
                              Text(
                                '$asset',
                                style: const TextStyle(
                                    color: Color(
                                      0xff828282,
                                    ),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Currency: ',
                              ),
                              Text(
                                '$currency',
                                style: const TextStyle(
                                    color: Color(
                                      0xff828282,
                                    ),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Amount: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: kPrimaryBlack),
                              ),
                              Text(
                                '\$${amount.toStringAsFixed(2).replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: kPrimaryBlack),
                              ),
                            ],
                          ),
                          Text(
                            bankName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: kPrimaryBlack),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
