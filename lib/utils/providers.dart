import 'package:brainepadia/models/loginusermodel.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  String token = '';
  Loginusermodel loginDetails = Loginusermodel();
  ProfileUserModel profileDetails = ProfileUserModel();
  WalletModel walletDetails = WalletModel();
  List transactionDetails = [];
  Map transactionDetailsdata = {};

  setLoginDetails(Loginusermodel details) {
    loginDetails = details;
    notifyListeners();
  }

  setProfile(ProfileUserModel profile) {
    profileDetails = profile;
    notifyListeners();
  }

  setWallet(WalletModel wallet) {
    walletDetails = wallet;
    notifyListeners();
  }

  setTransaction(List transactions) {
    transactionDetails = transactions;
    notifyListeners();
  }

  setTransactiondetials(Map transactionsDetails) {
    transactionDetailsdata = transactionsDetails;
    notifyListeners();
  }

  seToken(String finalToken) {
    token = finalToken;
    notifyListeners();
  }
}
