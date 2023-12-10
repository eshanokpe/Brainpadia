import 'package:brainepadia/Screens/dashboard/P2P/p2p_screen.dart';
import 'package:brainepadia/Screens/dashboard/Send/components/send_success.dart';
import 'package:brainepadia/Screens/dashboard/Send/send_screen.dart';
import 'package:brainepadia/Screens/dashboard/transaction/components/transaction_details.dart';
import 'package:brainepadia/Screens/dashboard/transaction/transaaction_page.dart';
import 'package:brainepadia/constants.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:brainepadia/providers/fetchBlockchain.dart';
import 'package:brainepadia/providers/providers.dart';
import 'package:brainepadia/providers/user_provider.dart';
import 'package:brainepadia/utilis/walletWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'components/home_content.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> currencies = ['USD', 'NGN']; // Add more currencies if needed
  String selectedCurrency = 'USD';
  int notificationCount = 5;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _refresh();
  }

  String? firstName;
  Future<void> _refresh() async {
    final p2pBuyAdsProvider =
        Provider.of<FetchBlockchain>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    p2pBuyAdsProvider.fetchTransaction(context);
    p2pBuyAdsProvider.fetchNairaBalance(context);
    p2pBuyAdsProvider.fetchDollarBalance(context);
    firstName = context.read<UserProvider>().getuser.firstName!;
    await Future.wait([
      context.read<FetchBlockchain>().fetchDollarBalance(context),
      context.read<FetchBlockchain>().fetchNairaBalance(context),
      context.read<FetchBlockchain>().fetchTransaction(context),
    ]);
  }

  void _onScroll() {
    setState(() {
      _isScrolled = _scrollController.hasClients &&
          _scrollController.offset > (kToolbarHeight / 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    WalletModel getWallet = Provider.of<UserProvider>(context).getuserWallet;
    final balance = Provider.of<Providers>(context).balance;
    var walletAddress = getWallet.walletAddress;

    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 315,
              floating: false,
              pinned: true,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              backgroundColor:
                  _isScrolled ? kPrimaryColor : walletappBackground,
              actionsIconTheme: const IconThemeData(opacity: 0.0),
              title: Container(
                padding: const EdgeInsets.fromLTRB(16, 42, 16, 32),
                margin: const EdgeInsets.only(bottom: 18, top: 8),
                child: Consumer<UserProvider>(builder: (context, userSate, _) {
                  return ListTile(
                    leading: userSate.getuser.imageUrl == null
                        ? const CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          )
                        : CachedNetworkImage(
                            imageUrl: userSate.getuser.imageUrl!,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 20,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) => const CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Colors.grey, // Placeholder background color
                              child:
                                  CircularProgressIndicator(), // Loading indicator
                            ),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  Colors.grey, // Placeholder background color
                              child: Icon(Icons.error), // Error icon or widget
                            ),
                          ),
                    title: Text(
                      'Hello, ${userSate.getuser.firstName!}',
                      // firstName!,
                      style: const TextStyle(
                        color: textColorWhite,
                        fontSize: 16,
                        fontFamily: fontRegular,
                      ),
                    ),
                    subtitle: const Text(
                      "How are you today?",
                      style: TextStyle(
                        color: textColorWhite,
                        fontSize: 16,
                        fontFamily: fontRegular,
                      ),
                    ),
                    trailing: Stack(
                      children: [
                        const Icon(
                          Icons.notifications,
                          size: 30,
                          color: textColorWhite,
                        ),
                        if (notificationCount > 0)
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                notificationCount.toString(),
                                style: const TextStyle(
                                  color: textColorWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topLeft,
                          colors: <Color>[kPrimaryColor, palColor],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 150, 16, 8),
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8, left: 10),
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: greyColor,
                                  size: 20,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 8, left: 8),
                                child: Text(
                                  'Total Balance',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 8),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black12,
                                  ),
                                  child: DropdownButton<String>(
                                    value:
                                        selectedCurrency, // Set the initial value of the dropdown
                                    items: currencies.map((currency) {
                                      return DropdownMenuItem<String>(
                                        value: currency,
                                        child: Text(currency),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      // Handle dropdown value change
                                      setState(() {
                                        selectedCurrency = value!;
                                      });
                                      print('Selected currency: $value');
                                    },
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    underline: const SizedBox(),
                                    dropdownColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Consumer<FetchBlockchain>(
                              builder: (context, transactionData, _) {
                            final fetchNairaBalance =
                                Provider.of<FetchBlockchain>(context,
                                    listen: false);
                            fetchNairaBalance.fetchNairaBalance(context);
                            final fetchDollarBalance =
                                Provider.of<FetchBlockchain>(context,
                                    listen: false);
                            fetchDollarBalance.fetchDollarBalance(context);
                            final balanceNaira = transactionData.balanceNaira;
                            final dollarbalance = transactionData.dollarbalance;
                            return SizedBox(
                              height: 100,
                              child: TopCard(
                                  amount: selectedCurrency == 'USD'
                                      ? "\$${dollarbalance.toStringAsFixed(2)}"
                                      : " ₦${balanceNaira!.toStringAsFixed(2)}",
                                  bal: balance.toString()),
                              //bal: "20"),
                            );
                          }),
                          const SizedBox(height: 2),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const Send();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kPrimaryColor,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(width: 30),
                                        Icon(
                                          Icons.send,
                                          color: textColorWhite,
                                          size: 24,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Send',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: textColorWhite,
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: kPrimaryColor,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(width: 30),
                                      Icon(
                                        Icons.monetization_on,
                                        color: textColorWhite,
                                        size: 24,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Withdraw',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: textColorWhite,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const P2P();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: kPrimaryColor,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(width: 30),
                                        // Image.asset(
                                        //   'assets/icons/p2p.png',
                                        //   height: 25,
                                        // ),
                                        Icon(
                                          Icons.people_alt,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'P2P',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: textColorWhite,
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildBody(walletAddress!),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(String walletAddress) {
    return Consumer<FetchBlockchain>(
      builder: (context, transactionData, _) {
        final p2pBuyAdsProvider =
            Provider.of<FetchBlockchain>(context, listen: false);
        p2pBuyAdsProvider.fetchTransaction(context);
        final transactionList = transactionData.transactionData;

        if (transactionList.isEmpty) {
          if (!transactionData.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFF9739E3),
            ));
          } else {
            return Center(
                child: Image.asset(
              'assets/icons/nodata.png',
              height: 120,
            ));
          }
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: transactionList.length + 1,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12, bottom: 8, top: 10),
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
              );
            }
            // final item = transactionList.reversed.toList()[index];
            final item = transactionList[index - 1];
            final fee = item['fee'];
            final amount = item['amount'];
            final recipient = item['recipient'];
            final timeStamp = item['timeStamp'];
            final hash = item['hash'];
            final sender = item['sender'];

            return walletAddress == recipient
                ? Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionDetails(
                                  title: 'Deposit Amount',
                                  timeStamp: timeStamp,
                                  amount: amount.toStringAsFixed(2),
                                  hash: hash,
                                  fee: fee,
                                  sender: sender,
                                  recipient: recipient),
                            ));
                      },
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(
                                color: const Color(0xff108C4A), width: 1.0)),
                        child: CircleAvatar(
                          backgroundImage: Image.asset(
                            "assets/images/send_icondown.png",
                            // width: 30, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                          ).image,
                        ),
                      ),
                      title: const Text('Deposit Amount',
                          style: TextStyle(
                            //color: const Color(0xff2B2D80),
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(
                        '${fee.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(children: [
                          Text(
                            formatDateTime(timeStamp),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "+${amount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Color(0xff3B802B),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                : Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionDetails(
                                  title: 'Withdraw Amount',
                                  timeStamp: timeStamp,
                                  hash: hash,
                                  amount: amount.toStringAsFixed(2),
                                  fee: fee,
                                  sender: sender,
                                  recipient: recipient),
                            ));
                      },
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            border: Border.all(
                                color: const Color(0xff108C4A), width: 1.0)),
                        child: CircleAvatar(
                          backgroundImage: Image.asset(
                            "assets/images/send_icon.png",
                            // width: 30, // Adjust the width as needed
                            height: 20, // Adjust the height as needed
                          ).image,
                        ),
                      ),
                      title: const Text('Withdraw Amount',
                          style: TextStyle(
                            // color: Color(0xff2B2D80),
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(
                        '${fee.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(children: [
                          Text(
                            formatDateTime(timeStamp),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "-${amount.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: const Color(0xffFF2A03),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.MMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return '$formattedDate, $formattedTime';
  }
}
