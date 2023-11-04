// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);
import 'dart:convert';

TransactionModel usermodelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));
String usermodelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.hash,
    this.timestamp,
    this.sender,
    this.recipient,
    this.amount,
    this.fee,
    this.height,
    this.pubkey,
    this.signature,
    this.transactionType,
  });

  final String? hash;
  final String? timestamp;
  final String? sender;
  final String? recipient;
  final int? amount;
  final double? fee;
  final int? height;
  final String? pubkey;
  final String? signature;
  final String? transactionType;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        hash: json['hash'],
        timestamp: json['timeStamp'], 
        sender: json['sender'],
        recipient: json['recipient'],
        amount: json['amount'],
        fee: json['fee'],
        height: json['height'],
        pubkey: json['pubkey'],
        signature: json['signature'],
        transactionType: json['transactionType'],
      );

  Map<String, dynamic> toJson() => {
        'hash': hash,
        'timeStamp': timestamp,
        'sender': sender,
        'recipient': recipient,
        'amount': amount,
        'fee': fee,
        'height': height,
        'pubkey': pubkey,
        'signature': signature,
        'transactionType': transactionType,
      };
}
