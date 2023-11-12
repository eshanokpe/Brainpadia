import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:brainepadia/screen/authentication/login.dart';
import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/image_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'transaction/send.dart';
import 'package:http/http.dart' as http;
import 'transaction/transactions.dart';
import 'transaction/transactionsDetails.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DialogBox dialogBox = DialogBox();

 
  @override
  Widget build(BuildContext context) {
    var email = context.watch<Providers>().loginDetails.email;
    var firstName = context.watch<Providers>().loginDetails.firstName;
    var lastName = context.watch<Providers>().loginDetails.lastName;
    var transactionDetails = context.watch<Providers>().transactionDetails;
    var getWallet = context.watch<Providers>().walletDetails;
    var getbalance = context.watch<Providers>().getbalance;
    var getDollarbalance = context.watch<Providers>().getDollarbalance;
    var getNaijabalance = context.watch<Providers>().getNaijabalance;
    var walletAddress = getWallet.walletAddress;
    print("getNaijabalance:$getNaijabalance");
    return WillPopScope( 
      onWillPop: () async {
        dialogBox.options(
            context, "Log Out", 'Are you sure you want to log out?', yes);
        return false; // Return false to prevent going back
      },
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/avatar_image.png'),
                      ),
                      title: Text(
                        firstName.toString() + lastName.toString(),
                        style: TextStyle(
                          color: ColorConstant.black900,
                          fontSize: getFontSize(
                            20,
                          ),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        email.toString(),
                        style: TextStyle(
                          fontSize: getFontSize(
                            14,
                          ),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      trailing: Stack(
                        children: [
                          Image.asset('assets/images/notification_icon.png'),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Brainepadia Coin',
                          style: TextStyle(
                            color: ColorConstant.gray700,
                            fontSize: getFontSize(20),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Balance',
                            style: TextStyle(
                              color: ColorConstant.gray500,
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '₦${getNaijabalance ?? 0}',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 99, 203, 141),
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${getbalance.toString()} BPC',
                            style: TextStyle(
                              color: ColorConstant.black900,
                              fontSize: getFontSize(
                                32,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '\$$getDollarbalance',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 119, 119, 119),
                              fontSize: getFontSize(
                                20,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Send()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  child: Image.asset('assets/images/send.png'),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Send',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 119, 119, 119),
                                    fontSize: getFontSize(
                                      20,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.primaryColor,
                                ),
                                child: Image.asset('assets/icons/receive.png'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Receieve',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119),
                                  fontSize: getFontSize(
                                    20,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.primaryColor,
                                ),
                                child: Image.asset('assets/icons/transfer.png'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Transfer',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119),
                                  fontSize: getFontSize(
                                    20,
                                  ),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 15, bottom: 10),
                child: Text(
                  'Transaction',
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: getFontSize(
                      25,
                    ),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Text(transactionDetails.toString()),
              SizedBox(
                //height: 400,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const BouncingScrollPhysics(), // Add the ScrollPhysics here

                    itemCount: transactionDetails.length,
                    itemBuilder: (context, index) {
                      // ignore: unnecessary_null_comparison
                      if (transactionDetails == null) {
                        // Handle the case when supportData is null
                        return const Center(
                          child: Text('Node is Not Responding'),
                        ); // or any other appropriate widget
                      }
                      Map<String, dynamic> item = transactionDetails[index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 10),
                              child: Text(
                                formatDateTime(item['timeStamp']),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 119, 119, 119)),
                              ),
                            ),
                            getWallet.walletAddress == item['recipient']
                                ? ListTile(
                                    onTap: () async {
                                      dialogBox.waiting(context, 'Loadig...');
                                      var timer = Timer(
                                          const Duration(milliseconds: 30000),
                                          () {
                                        Navigator.pop(context);
                                        dialogBox.information(context, 'Status',
                                            'Service timed out');
                                        return;
                                      });
                                      //print('${item['hash']}');
                                      var urlgetTransaction = Uri.parse(
                                          "$baseUrl/BPCoin/get_transaction_by_hash?hash=${item['hash']}");
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var token = prefs.getString('tokenDB');
                                      var responseTransaction = await http
                                          .get(urlgetTransaction, headers: {
                                        "Authorization": 'Bearer $token'
                                      });
                                      //print(responseTransaction.statusCode);
                                      if (responseTransaction.statusCode ==
                                          200) {
                                        var sendWalletData = jsonDecode(
                                            responseTransaction.body);
                                        Map transactionData =
                                            sendWalletData['data'];
                                        //print('transactionDatails:$transactionData');
                                        context
                                            .read<Providers>()
                                            .setTransactiondetials(
                                                transactionData);
                                        timer.cancel();
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TransactionsDetails()));
                                      } else {
                                        timer.cancel();
                                        Navigator.pop(context);
                                        dialogBox.information(context, 'Error',
                                            'Transaction response Error');
                                      }
                                    },
                                    leading: const CircleAvatar(
                                      radius: 19,
                                      backgroundImage: AssetImage(
                                          'assets/icons/send_icondown.png'),
                                    ),
                                    title: const Text('Deposit Amount',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'poppins',
                                          fontSize: 20,
                                        )),
                                    subtitle: const Text(
                                      'Successful',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 16, 140, 74)),
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          '${item['amount']} BPC',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${item['fee'].toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 119, 119, 119)),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListTile(
                                    onTap: () async {
                                      dialogBox.waiting(context, 'Loadig...');
                                      var timer = Timer(
                                          const Duration(milliseconds: 30000),
                                          () {
                                        Navigator.pop(context);
                                        dialogBox.information(context, 'Status',
                                            'Service timed out');
                                        return;
                                      });
                                      //print('${item['hash']}');
                                      var urlgetTransaction = Uri.parse(
                                          "$baseUrl/BPCoin/get_transaction_by_hash?hash=${item['hash']}");
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var token = prefs.getString('tokenDB');
                                      var responseTransaction = await http
                                          .get(urlgetTransaction, headers: {
                                        "Authorization": 'Bearer $token'
                                      });
                                      //print(responseTransaction.statusCode);
                                      if (responseTransaction.statusCode ==
                                          200) {
                                        var sendWalletData = jsonDecode(
                                            responseTransaction.body);
                                        Map transactionData =
                                            sendWalletData['data'];
                                        //print('transactionDatails:$transactionData');
                                        context
                                            .read<Providers>()
                                            .setTransactiondetials(
                                                transactionData);
                                        timer.cancel();
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TransactionsDetails()));
                                      } else {
                                        timer.cancel();
                                        Navigator.pop(context);
                                        dialogBox.information(context, 'Error',
                                            'Transaction response Error');
                                      }
                                    },
                                    leading: const CircleAvatar(
                                      radius: 19,
                                      backgroundImage: AssetImage(
                                          'assets/icons/send_icon.png'),
                                    ),
                                    title: const Text('Withdraw Amount',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    subtitle: const Text(
                                      'Successful',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 16, 140, 74)),
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          '${item['amount']} BPC',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${item['fee'].toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 119, 119, 119)),
                                        ),
                                      ],
                                    ),
                                  ),
                            //Text(getWallet.walletAddress.toString()),
                          ],
                        ),
                      );
                    }),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text('View more'),
                  onPressed: () async {
                    dialogBox.waiting(context, 'Loadig...');
                    var timer = Timer(const Duration(milliseconds: 30000), () {
                      Navigator.pop(context);
                      dialogBox.information(
                          context, 'Status', 'Service timed out');
                      return;
                    });
                    var urlgetTransaction = Uri.parse(
                        "$baseUrl/BPCoin/get_transaction_by_address?userAddress=$walletAddress&pageNumber=1&resultPerPage=20");
                    final prefs = await SharedPreferences.getInstance();
                    var token = prefs.getString('tokenDB');
                    var responseTransaction = await http.get(urlgetTransaction,
                        headers: {"Authorization": 'Bearer $token'});
                    if (responseTransaction.statusCode == 200) {
                      Map<String, dynamic> sendWalletData =
                          jsonDecode(responseTransaction.body);
                      List transactionData = sendWalletData['data'];
                      //print('transactionData:$transactionData');
                      context.read<Providers>().setTransaction(transactionData);
                      timer.cancel();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Transactions()));
                    } else {
                      timer.cancel();
                      Navigator.pop(context);
                      dialogBox.information(
                          context, 'Error', 'Transaction response Error');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.MMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return '$formattedDate, $formattedTime';
  }

  yes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenDB', 'logout');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}
