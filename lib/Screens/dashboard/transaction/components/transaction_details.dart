import 'package:brainepadia/constants.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatelessWidget {
  final String recipient;
  final String amount;
  final String title;
  final String timeStamp;
  final String sender;
  final String hash;
  final num fee;

  const TransactionDetails({
    Key? key,
    required this.recipient,
    required this.amount,
    required this.title,
    required this.timeStamp,
    required this.sender,
    required this.fee,
    required this.hash,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              buildHeader(title),
              SizedBox(height: 20),
              _buildTransactionDetailHash('Transaction ID', hash),
              _buildTransactionTimeStamp('Date', timeStamp),
              _buildTransactionAmount('Amount', amount),
              _buildTransactionDetailRow('Sender', sender),
              _buildTransactionDetailRow('Recipient', recipient),
              _buildTransactionFee('Fee', fee),
              _buildTransactionDetailRow('Transaction Type', 'Payment'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionFee(String label, num value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              value.toDouble().toStringAsFixed(2),
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account: $title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Status: Successful',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // Add functionality for "Repeat Transaction"
          },
          child: Text('Repeat Transaction'),
        ),
        ElevatedButton(
          onPressed: () {
            // Add functionality for "View Receipt"
          },
          child: Text('View Receipt'),
        ),
      ],
    );
  }

  Widget _buildTransactionAmount(String label, String amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              "$amount BPCoin",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTransactionTimeStamp(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            formatDateTime(value),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

String formatDateTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  final formattedDate = DateFormat.yMMMd().format(dateTime);
  final formattedTime = DateFormat.jm().format(dateTime);

  return '$formattedDate, $formattedTime';
}

Widget _buildTransactionDetailRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTransactionDetailHash(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    if (value == "") {
                      print('enter text');
                    } else {
                      print("walletAddress:$value");
                      FlutterClipboard.copy(value).then((value) {
                        Fluttertoast.showToast(msg: 'Text copied');
                      });
                    }
                  },
                  child: Icon(Icons.copy, color: kSecondaryColor, size: 20)),
              SizedBox(width: 1),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
