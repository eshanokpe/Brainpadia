import 'package:brainepadia/utils/color_constant.dart';
import 'package:brainepadia/utils/math_utils.dart';
import 'package:brainepadia/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsDetails extends StatefulWidget {
  const TransactionsDetails({super.key});

  @override
  State<TransactionsDetails> createState() => _TransactionsDetailsState();
}

class _TransactionsDetailsState extends State<TransactionsDetails> {
  @override
  Widget build(BuildContext context) {
    var transactionDetails = context.watch<Providers>().transactionDetailsdata;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:
          AppBar(centerTitle: true, title: const Text('Transaction Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Card(
                elevation: 1,
                child: Center(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${transactionDetails['amount'].toString()} BPC',
                      style: TextStyle(
                        color: ColorConstant.black900,
                        fontSize: getFontSize(
                          30,
                        ),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Successful',
                      style: TextStyle(color: Color.fromARGB(255, 16, 140, 74)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Card(
                elevation: 1,
                child: Container(
                  width: size.width * 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Transaction Details',
                          style: TextStyle(
                            color: ColorConstant.black900,
                            fontSize: getFontSize(
                              20,
                            ),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          isThreeLine: true,
                          leading: const Text('Sender Details'),
                          subtitle: Text(
                              '${transactionDetails['sender'].toString()} '),
                        ),
                        ListTile(
                          isThreeLine: true,
                          leading: const Text('Recipient Details'),
                          subtitle: Text(
                              '${transactionDetails['recipient'].toString()} '),
                        ),
                        ListTile(
                          isThreeLine: true,
                          leading: const Padding(
                            padding: EdgeInsets.only(right: 13.0),
                            child: Text('Fee                  '),
                          ),
                          subtitle: Text(
                              '${transactionDetails['fee'].toStringAsFixed(2)} '),
                        ),
                        ListTile(
                          isThreeLine: true,
                          leading: const Padding(
                            padding: EdgeInsets.only(right: 23.0),
                            child: Text('Date             '),
                          ),
                          subtitle: Text(
                              formatDateTime(transactionDetails['timeStamp'])),
                          //  '${transactionDetails['timeStamp'].toStringAsFixed(2)} '),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
}
