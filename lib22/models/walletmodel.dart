// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);
import 'dart:convert';

WalletModel usermodelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));
String usermodelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    this.walletId,
    this.amount,
    this.walletType,
    this.walletAddress,
    this.publicKey,
    this.secretNumber,
    this.profileId,
    this.profile,
    this.dateCreated,
    this.userCreated,
    this.dateModified,
    this.userModified,
  });

  final int? walletId;
  final int? amount;
  final String? walletType;
  final String? walletAddress;
  final String? publicKey;
  final int? secretNumber;
  final int? profileId;
  final String? profile;
  final String? dateCreated;
  final String? userCreated;
  final String? dateModified;
  final String? userModified;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        walletId: json['walletId'],
        amount: json['amount'],
        walletType: json['walletType'],
        walletAddress: json['walletAddress'],
        publicKey: json['publicKey'],
        secretNumber: json['secretNumber'],
        profileId: json['profileId'],
        profile: json['profile'],
        dateCreated: json['dateCreated'],
        userCreated: json['userCreated'],
        dateModified: json['dateModified'],
        userModified: json['userModified'],
      );

  Map<String, dynamic> toJson() => {
        'walletId': walletId,
        'amount': amount,
        'walletType': walletType,
        'walletAddress': walletAddress,
        'publicKey': publicKey,
        'secretNumber': secretNumber,
        'profileId': profileId,
        'profile': profile,
        'dateCreated': dateCreated,
        'userCreated': userCreated,
        'dateModified': dateModified,
        'userModified': userModified,
      };
}
