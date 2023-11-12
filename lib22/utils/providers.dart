import 'dart:convert';
import 'package:brainepadia/utilis/constants.dart';
import 'package:http/http.dart' as http;
import 'package:brainepadia/models/loginusermodel.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  String? username;
  String? password;
  bool isLoading = false;

  String token = '';
  Loginusermodel loginDetails = Loginusermodel();
  ProfileUserModel profileDetails = ProfileUserModel();
  WalletModel walletDetails = WalletModel();
  List transactionDetails = [];
  int? getbalance;
  var getDollarbalance;
  int? getNaijabalance;
  Map transactionDetailsdata = {};

  Future<void> login(BuildContext context) async {
    try {
      setLoading(true);
      var loginUrl = Uri.parse("$baseUrl/Account/auth_login");

      // Create JSON payload for login request
      var payload = jsonEncode(
          {"email": username, "password": password, "rememberMe": true});

      // Send login request
      var response = await http.post(loginUrl,
          headers: {"Content-Type": "application/json"}, body: payload);

      // Handle login response
      if (response.statusCode == 200) {
        print("Login successful!");
        var authToken = jsonDecode(response.body)["token"];
        // Store the auth token for future API requests
      } else {
        print("Login failed. Error: ${response.body}");
        // Handle login failure
      }
    } catch (error) {
      print("Login failed. Error: $error");
      // Handle login exception
    } finally {
      setLoading(false);
    }
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

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

  setGetbalance(int getBalance) {
    getbalance = getBalance;
  }

  setGetdollarbalance(var getdollarbalance) {
    getDollarbalance = getdollarbalance;
  }

  setGetnaijabalance(int getNaijabalance) {
    getNaijabalance = getNaijabalance;
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
