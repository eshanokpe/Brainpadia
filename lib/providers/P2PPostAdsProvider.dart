// ignore: file_names
import 'dart:convert';
import 'package:brainepadia/Screens/dashboard/PostAds/viewpostads_screen.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/utilis/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'user_provider.dart';

class P2PPostAdsProvider with ChangeNotifier {
  bool isLoading = false;
  bool get isLoadingSend => isLoading;
  User _user = User();
  User? get user => _user;
  List<Map<String, dynamic>> _p2pBuyAds = [];
  List<Map<String, dynamic>> get p2pBuyAds => _p2pBuyAds;
  List<Map<String, dynamic>> _p2pSellAds = [];
  List<Map<String, dynamic>> get p2pSellAds => _p2pSellAds;
  List<Map<String, dynamic>> _p2pUserBuyAds = [];
  List<Map<String, dynamic>> get p2pUserBuyAds => _p2pUserBuyAds;
  List<Map<String, dynamic>> _p2pUserSellAds = [];
  List<Map<String, dynamic>> get p2pUserSellAds => _p2pUserSellAds;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> sendBuyPostAds(
      BuildContext context,
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
      "profileId": profileId
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
        Fluttertoast.showToast(msg: responseData["message"]);
        final p2pSellAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);

        await p2pSellAdsProvider.fetchP2PUserBuyAds();
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
        Fluttertoast.showToast(msg: responseData.toString());
      }
    } catch (error) {
      setLoading(false);
      Fluttertoast.showToast(msg: 'An error occurred');
    }
  }

  Future<void> fetchP2PBuyAds() async {
    final token = user!.token;
    //print("token$token");
    final url = Uri.parse('$baseUrl/P2PBuyAds/get_all_p2pbuyads');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      _p2pBuyAds = data.map((item) => item as Map<String, dynamic>).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch P2P Sell Ads');
    }
  }

  Future<void> fetchP2PSellAds() async {
    final token = user!.token;
    //print("token$token");
    const url = '$baseUrl/P2PBuyAds/get_all_p2pbuyads';

    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        print("_p2pSellAds:$_p2pSellAds");
        _p2pSellAds = data.map((item) => item as Map<String, dynamic>).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch P2P Sell Ads');
      }
    } catch (e) {
      throw Exception('Failed to fetch P2P Sell Ads: $e');
    }
  }

  Future<void> fetchP2PUserBuyAds() async {
    final token = user!.token;
    final profileId = user!.profileId;
    //print("p2pUserdatatoken$token");
    final url =
        Uri.parse('$baseUrl/P2PBuyAds/get_user_p2pbuyads?profileId=$profileId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      //print("p2pUserdata:$data");

      _p2pUserBuyAds =
          data.map((item) => item as Map<String, dynamic>).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch P2P Sell Ads');
    }
  }

  // Future<void> fetchP2PUserSellAds22() async {
  //   final token = user!.token;
  //   final profileId = user!.profileId;
  //   //print("p2pUserdatatoken$token");
  //   final url = Uri.parse(
  //       '$baseUrl/P2PSellAds/get_user_p2psellads?profileId=$profileId');
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       "Authorization": 'Bearer $token'
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     //print("data:$data");
  //     //print("p2pUserdata:$data");
  //     //Fluttertoast.showToast(msg: 'Correct222');
  //     _p2pUserSellAds =
  //         data.map((item) => item as Map<String, dynamic>).toList();
  //     notifyListeners();
  //   } else {
  //     Fluttertoast.showToast(msg: 'Error');
  //   }
  // }

  Future<void> fetchP2PUserSellAds() async {
    final token = user!.token;
    final profileId = user!.profileId;
    print("SellprofileId:$profileId");
    Dio dio = Dio(); // Initialize Dio

    try {
      Response response = await dio.get(
        '$baseUrl/P2PSellAds/get_user_p2psellads?profileId=$profileId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> sellbankData = response.data;

        //print("sellbankData:$sellbankData");
        // _sellbanksdata = sellbankData.map((bank) => Bank.fromJson(bank)).toList();
        //Fluttertoast.showToast(msg: 'Correct111');
        _p2pUserSellAds =
            sellbankData.map((item) => item as Map<String, dynamic>).toList();
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: 'Error');
      }
    } catch (error) {
      print('An error occurred');
      //Fluttertoast.showToast(msg: 'An error occurred');
    }
  }

  Future<void> editBuyPostAds(BuildContext context, int p2PBuyAdsId,
      String amount, String price, String limitFrom, String limitTo) async {
    setLoading(true);
    notifyListeners();

    try {
      final profileId =
          Provider.of<UserProvider>(context, listen: false).getuser.profileId;
      final token = user!.token;
      final url = Uri.parse("$baseUrl/P2PBuyAds/edit/$p2PBuyAdsId");

      final data = {
        "p2PBuyAdsId": p2PBuyAdsId,
        "asset": "string",
        "currency": "string",
        "amount": amount,
        "price": price,
        "limitFrom": limitFrom,
        "limitTo": limitTo,
        "profileId": profileId
      };
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final p2pSellAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);
        p2pSellAdsProvider.fetchP2PUserBuyAds();

        final responseData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: responseData["message"]);
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
        setLoading(false);
        notifyListeners();
      } else {
        final responseData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: responseData.toString());
        setLoading(false);
        notifyListeners();
      }
    } catch (error) {
      setLoading(false);
      Fluttertoast.showToast(msg: 'An error occurred');
    }
  }

  Future<void> editSellPostAds(BuildContext context, int p2PSellAdsId,
      String amount, String price, String limitFrom, String limitTo) async {
    setLoading(true);
    notifyListeners();

    try {
      final profileId =
          Provider.of<UserProvider>(context, listen: false).getuser.profileId;
      final token = user!.token;
      final url = Uri.parse("$baseUrl/P2PSellAds/edit/$p2PSellAdsId");

      final data = {
        "p2PSellAdsId": p2PSellAdsId,
        "asset": "string",
        "currency": "string",
        "amount": amount,
        "price": price,
        "limitFrom": limitFrom,
        "limitTo": limitTo,
        "profileId": profileId
      };
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final p2pSellAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);

        p2pSellAdsProvider.fetchP2PUserSellAds();
        p2pSellAdsProvider.fetchP2PUserBuyAds();

        final responseData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: responseData["message"]);
        setLoading(false);
        notifyListeners();
        Navigator.pushReplacement(
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
        Fluttertoast.showToast(msg: responseData.toString());
      }
    } catch (error) {
      setLoading(false);
      Fluttertoast.showToast(msg: 'An error occurred');
    }
  }

  Future<void> deleteBuyPostAds(BuildContext context, int p2PBuyAdsId) async {
    setLoading(true);
    notifyListeners();

    try {
      final token = user!.token;
      final url = Uri.parse("$baseUrl/P2PBuyAds/delete/$p2PBuyAdsId");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final p2pBuyAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);

        //p2pSellAdsProvider.fetchP2PUserSellAds();
        await p2pBuyAdsProvider.fetchP2PUserBuyAds();
        final responseData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: responseData["message"]);

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
        setLoading(false);
        notifyListeners();
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

  Future<void> deleteSellPostAds(BuildContext context, int p2PSellAdsId) async {
    setLoading(true);
    notifyListeners();

    try {
      final token = user!.token;
      final url = Uri.parse("$baseUrl/P2PSellAds/delete/$p2PSellAdsId");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final p2pSellAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);

        p2pSellAdsProvider.fetchP2PUserSellAds();
        p2pSellAdsProvider.fetchP2PUserBuyAds();

        final responseData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: responseData["message"]);

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
        setLoading(false);
        notifyListeners();
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
}
