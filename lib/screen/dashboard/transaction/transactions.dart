import 'dart:async';
import 'dart:convert';

import 'package:brainepadia/utils/constants.dart';
import 'package:brainepadia/utils/dialog.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'transactionsDetails.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  DialogBox dialogBox = DialogBox();
  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.MMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return '$formattedDate, $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    var transactionDetails = context.watch<Providers>().transactionDetails;
    var getWallet = context.watch<Providers>().walletDetails;
    var walletAddress = getWallet.walletAddress;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back arrow icon
          centerTitle: true,
          title: const Text('Transaction')),
      body: ListView(
        children: [
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
                      child: Text('No Transaction'),
                    ); // or any other appropriate widget
                  }
                  Map<String, dynamic> item = transactionDetails[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 10),
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
                                      const Duration(milliseconds: 30000), () {
                                    Navigator.pop(context);
                                    dialogBox.information(
                                        context, 'Status', 'Service timed out');
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
                                  if (responseTransaction.statusCode == 200) {
                                    var sendWalletData =
                                        jsonDecode(responseTransaction.body);
                                    Map transactionData =
                                        sendWalletData['data'];
                                    //print('transactionDatails:$transactionData');
                                    context
                                        .read<Providers>()
                                        .setTransactiondetials(transactionData);
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
                                      color: Color.fromARGB(255, 16, 140, 74)),
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
                                      const Duration(milliseconds: 30000), () {
                                    Navigator.pop(context);
                                    dialogBox.information(
                                        context, 'Status', 'Service timed out');
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
                                  if (responseTransaction.statusCode == 200) {
                                    var sendWalletData =
                                        jsonDecode(responseTransaction.body);
                                    Map transactionData =
                                        sendWalletData['data'];
                                    //print('transactionDatails:$transactionData');
                                    context
                                        .read<Providers>()
                                        .setTransactiondetials(transactionData);
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
                                  backgroundImage:
                                      AssetImage('assets/icons/send_icon.png'),
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
                                      color: Color.fromARGB(255, 16, 140, 74)),
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
        ],
      ),
    );
  }
}
