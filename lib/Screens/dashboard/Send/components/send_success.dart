import 'package:brainepadia/Screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuccessTransactionScreen extends StatelessWidget {
  final String walletId;
  final num amount;
  final String transactionDate;

  const SuccessTransactionScreen(
      {Key? key,
      required this.walletId,
      required this.amount,
      required this.transactionDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Successful'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Your transaction of ${amount.toStringAsFixed(2)} BPC was successful.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Text(
              'Date: ${_formatDate(transactionDate)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Wallet ID: $walletId',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen or perform another action
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate = DateFormat.yMMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return '$formattedDate, $formattedTime';
  }
}
