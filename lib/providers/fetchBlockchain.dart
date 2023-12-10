// ignore: file_names
import 'dart:convert';

import 'package:brainepadia/Screens/dashboard/PostAds/viewpostads_screen.dart';
import 'package:brainepadia/Screens/dashboard/dashboard.dart';
import 'package:brainepadia/Screens/dashboard/profile/components/view_profile.dart';
import 'package:brainepadia/Screens/dashboard/profile/profile_page.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:brainepadia/utilis/constants.dart';
import 'package:brainepadia/utilis/shared_preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'P2PPostAdsProvider.dart';
import 'providers.dart';
import 'user_provider.dart';

class FetchBlockchain with ChangeNotifier {
  final Dio dio = Dio();
  bool isLoading = false;
  bool get isLoadingSend => isLoading;
  double _balanceDollar = 0;
  double? _balanceNaira = 0.0;

  List _transactionDataAll = [];
  double get dollarbalance => _balanceDollar;
  double? get balanceNaira => _balanceNaira;
  List<dynamic> _transactionData = [];
  List<dynamic> get transactionData => _transactionData;
  List get transactionDataAll => _transactionDataAll;
  User _user = User();
  User? get user => _user;
  ProfileUserModel _getuser = ProfileUserModel();
  ProfileUserModel get getuser => _getuser;

  Future<void> fetchDollarBalance(BuildContext context) async {
    Providers userProvider = Provider.of<Providers>(context, listen: false);
    var balance = userProvider.balance;
    var token = user!.token;
    var url = "$baseUrl/BPCoin/bpcoin_to_dollar?bpcoin=$balance";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is int) {
        _balanceDollar = responseData.toDouble();
      } else if (responseData is double) {
        _balanceDollar = responseData;
      } else {
        throw Exception('Invalid data type for balance');
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load balance');
    }
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserprofile(ProfileUserModel getuser) {
    _getuser = getuser;
    notifyListeners();
  }

  Future<void> fetchNairaBalance(BuildContext context) async {
    Providers userProvider = Provider.of<Providers>(context, listen: false);
    var balance = userProvider.balance;
    var tokensNaira = user!.token;
    var url = "$baseUrl/BPCoin/bpcoin_to_naira?bpcoin=$balance";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": 'Bearer $tokensNaira'});
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is int) {
        _balanceNaira = responseData.toDouble();
        notifyListeners();
      } else if (responseData is double) {
        _balanceNaira = responseData;
        notifyListeners();
      } else {
        throw Exception('Invalid response data type');
      }

      print('_balanceNaira: $_balanceNaira');
    } else {
      throw Exception('Failed to load balance');
    }
  }

  Future<void> fetchTransaction(BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var token = user!.token;
    //print('tokens:$token');
    WalletModel userWallet = userProvider.getuserWallet;
    String walletAddress = userWallet.walletAddress!;
    var url =
        "$baseUrl/BPCoin/get_transaction_by_address?userAddress=$walletAddress&pageNumber=1&resultPerPage=10";

    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _transactionData = responseData['data'];
      //print('_transactionData:$_transactionData');
      notifyListeners();
    } else {
      throw Exception('Failed to load balance');
    }
  }

  Future<void> fetchTransactionAll(BuildContext context) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var token = user!.token;
    WalletModel userWallet = userProvider.getuserWallet;
    String walletAddress = userWallet.walletAddress!;
    var url =
        "$baseUrl/BPCoin/get_transaction_by_address?userAddress=$walletAddress&pageNumber=1&resultPerPage=50";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": 'Bearer $token'});
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _transactionDataAll = responseData['data'];
      notifyListeners();
    } else {
      throw Exception('Failed to load balance');
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> sendBuyPostAds(
      BuildContext context,
      String getbankId,
      String asset,
      String currency,
      String amount,
      String price,
      String limitFrom,
      String limitTo) async {
    setLoading(true);
    notifyListeners();

    final profileId =
        Provider.of<UserProvider>(context, listen: false).getuser.profileId;
    final token = user!.token;

    final url = Uri.parse("$baseUrl/P2PBuyAds/add_p2pbuyads");
    final data = {
      "asset": asset,
      "currency": currency,
      "amount": amount,
      "price": price,
      "limitFrom": limitFrom,
      "limitTo": limitTo,
      "profileId": profileId,
      "bankDetailsId": getbankId
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        setLoading(false);
        final responseData = jsonDecode(response.body);
        print("sendBuyPostAds:$responseData");
        Fluttertoast.showToast(msg: responseData["message"]);
        final p2pBuyAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);
        p2pBuyAdsProvider.fetchP2PUserSellAds();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const PostAds(
                  initialTabIndex:
                      1); // Pass the initialTabIndex as an argument
            },
          ),
        );
      } else {
        setLoading(false);
        final responseData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: responseData.toString());
      }
    } catch (error) {
      setLoading(false);
      Fluttertoast.showToast(msg: 'An error occurred');
    }
  }

  Future<void> sendSellPostAds(
      BuildContext context,
      String getbankId,
      String asset,
      String currency,
      String amount,
      String price,
      String limitFrom,
      String limitTo) async {
    setLoading(true);
    notifyListeners();

    final token = user!.token;
    final profileId = user!.profileId;
    final url = Uri.parse("$baseUrl/P2PSellAds/add_p2psellads");
    final data = {
      "asset": asset,
      "currency": currency,
      "amount": amount,
      "price": price,
      "limitFrom": limitFrom,
      "limitTo": limitTo,
      "bankDetailsId": getbankId
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      );

      print("responseData:${response.statusCode}");
      if (response.statusCode == 200) {
        setLoading(false);
        final responseData = jsonDecode(response.body);
        print("responseData:$responseData");
        Fluttertoast.showToast(msg: responseData["message"]);
        final p2pBuyAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);
        p2pBuyAdsProvider.fetchP2PUserBuyAds();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const PostAds(
                  initialTabIndex:
                      0); // Pass the initialTabIndex as an argument
            },
          ),
        );
      } else {
        setLoading(false);
        final responseData = jsonDecode(response.body);
        print("responseData:$responseData");
        Fluttertoast.showToast(msg: responseData.toString());
      }
    } catch (error) {
      setLoading(false);
      Fluttertoast.showToast(msg: 'An error occurred');
    }
  }
}
