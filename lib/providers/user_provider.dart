import 'dart:convert';
import 'dart:io';
import 'package:brainepadia/Screens/dashboard/Send/components/send_success.dart';
import 'package:brainepadia/Screens/dashboard/profile/bankDetails/getBank.dart';
import 'package:brainepadia/Screens/dashboard/profile/components/view_profile.dart';
import 'package:brainepadia/Screens/dashboard/profile/profile_page.dart';
import 'package:brainepadia/utilis/dialog.dart';
import 'package:http/http.dart' as http;
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:brainepadia/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final Dio dio = Dio();
  bool _iscurrentPasswordVisible = false;
  bool get iscurrentPasswordVisible => _iscurrentPasswordVisible;
  void toggleCurrentPasswordVisibility() {
    _iscurrentPasswordVisible = !_iscurrentPasswordVisible;
    notifyListeners();
  }

  bool _isnewPasswordVisible = false;
  bool get isnewPasswordVisible => _isnewPasswordVisible;
  void toggleNewPasswordVisibility() {
    _isnewPasswordVisible = !_isnewPasswordVisible;
    notifyListeners();
  }

  bool _isconPasswordVisible = false;
  bool get isconPasswordVisible => _isconPasswordVisible;
  void toggleConPasswordVisibility() {
    _isconPasswordVisible = !_isconPasswordVisible;
    notifyListeners();
  }

  double? _profileFee = 0.0;
  double? _feeAmount;
  double? get feeAmount => _feeAmount;

  ProfileUserModel _getuser = ProfileUserModel();
  User _user = User();
  User get user => _user;
  ProfileUserModel get getuser => _getuser;
  WalletModel _getWallet = WalletModel();
  WalletModel get getuserWallet => _getWallet;
  double? get profileFee => _profileFee;
  DialogBox dialogBox = DialogBox();
  bool sendgetLoading = false;
  bool _isLoadingSend = false;
  List<Map<String, dynamic>> _getBankData = [];
  List<Map<String, dynamic>> get getBankData => _getBankData;
  bool get isLoadingSend => _isLoadingSend;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserprofile(ProfileUserModel getuser) {
    _getuser = getuser;
    notifyListeners();
  }

  void setUserwallet(WalletModel getWallet) {
    _getWallet = getWallet;
    notifyListeners();
  }

  void fetchFee(dynamic fee) {
    if (fee is int) {
      _profileFee = fee.toDouble();
    } else if (fee is double) {
      _profileFee = fee;
    } else {
      _profileFee = null;
    }
    print("fee: $_profileFee");
    notifyListeners();
  }

  bool getLoading = false;
  void setgetLoading(bool value) {
    getLoading = value;
    notifyListeners();
  }

  void setLoadingSend(bool value) {
    _isLoadingSend = value;
    notifyListeners();
  }

  String? amount;
  String? recipient;

  void setAmount(String value) {
    amount = value;
    notifyListeners();
  }

  void setRecipient(String value) {
    recipient = value;
    notifyListeners();
  }

  Future<void> fetchProfileFee(BuildContext context) async {
    String? amount;
    print('amount:$amount');

    var feeUrl = Uri.parse("$baseUrl/BPCoin/get_fee?amount=$amount");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString('token');
    var response =
        await http.get(feeUrl, headers: {"Authorization": 'Bearer $tokens'});

    if (response.statusCode == 200) {
      _feeAmount = jsonDecode(response.body);
      notifyListeners();
      print('_feeAmount:$_feeAmount');
    } else {
      //throw Exception('Failed to fetch profile fee');
      print('Failed to fetch profile fee');
    }
  }

  Future<void> saveChangePassword(BuildContext context, String currentPassword,
      String newPassword, String confirmNewPassword) async {
    setLoadingSend(true);
    notifyListeners();
    try {
      var token = user.token;
      var email = user.email;
      print("email:$email");
      print("currentPassword:$currentPassword");
      print("newPassword:$newPassword");
      print("confirmNewPassword:$confirmNewPassword");
      dio.options.headers['Authorization'] = 'Bearer $token';
      var url = "$baseUrl/Account/change_password";

      var payload = jsonEncode({
        "email": email,
        "oldPassword": currentPassword,
        "password": newPassword,
        "confirmPassword": confirmNewPassword
      });
      final response = await dio.post(
        url,
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print("object:${response.statusCode}");
      if (response.statusCode == 200) {
        setLoadingSend(false);
        Map<String, dynamic> userProfile = response.data;
        print("Sucess:$userProfile");
        Fluttertoast.showToast(msg: userProfile['message']);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewProfile(),
            ));
      } else {
        setLoadingSend(false);
        Map<String, dynamic> userProfile = response.data;
        print("Error:$userProfile");
        Fluttertoast.showToast(msg: userProfile['message']);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("Incorrect password");
      // Handle OTP code validation exception
    } finally {
      sendLoading(false);
    }
  }

  Future<void> sendGetOTP() async {
    try {
      setgetLoading(true);
      notifyListeners();
      var email = user.email;
      print('email:$email');
      var feeUrl = Uri.parse("$baseUrl/Account/resend_otp?email=$email");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var tokens = prefs.getString('token');
      var response =
          await http.get(feeUrl, headers: {"Authorization": 'Bearer $tokens'});

      if (response.statusCode == 200) {
        handleSuccess(jsonDecode(response.body));
      } else {
        handleFailure(jsonDecode(response.body));
      }
    } catch (error) {
      handleError(error);
    } finally {
      setgetLoading(false);
    }
  }

  void handleSuccess(Map<String, dynamic> data) {
    Fluttertoast.showToast(msg: '${data["message"]}');
  }

  void handleFailure(Map<String, dynamic> data) {
    Fluttertoast.showToast(msg: '${data["message"]}');
    // throw Exception('Failed $data');
    print('data:${data["message"]}');
  }

  void handleError(dynamic error) {
    Fluttertoast.showToast(msg: 'Error: $error');
    print("OTP code validation failed. Error: $error");
    // Handle OTP code validation exception
  }

  void sendLoading(bool value) {
    sendgetLoading = value;
    notifyListeners();
  }

  Future<void> oTPSendVerification(
    BuildContext context,
    String otp,
    String recipient,
    String walletAddress,
    String amount,
    String fee,
  ) async {
    try {
      sendLoading(true);
      notifyListeners();
      var email = user.email;
      var tokens = (await SharedPreferences.getInstance()).getString('token');
      var validateOTPUrl = Uri.parse(APIEndpoints.postOTP);
      var payload = jsonEncode({
        "email": email,
        "otp": otp,
      });
      // Send OTP code validation request
      var response = await http.post(validateOTPUrl,
          headers: {"Content-Type": "application/json"}, body: payload);
      var sendCoinUrl = Uri.parse(
          "$baseUrl/BPCoin/send_coin?recipientAddress=$recipient&senderAddress=$walletAddress&amount=$amount&fee=$fee");

      if (response.statusCode == 400) {
        var responsesendCoin = await http
            .get(sendCoinUrl, headers: {"Authorization": 'Bearer $tokens'});

        if (responsesendCoin.statusCode == 200) {
          Map<String, dynamic> sendCoinData = jsonDecode(responsesendCoin.body);
          String walletId = sendCoinData["data"]["recipient"];
          num amount = sendCoinData["data"]["amount"];
          String timeStamp = sendCoinData["data"]["timeStamp"];
          Fluttertoast.showToast(msg: '${sendCoinData["message"]}');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessTransactionScreen(
                    transactionDate: timeStamp,
                    amount: amount,
                    walletId: walletId),
              ));
          //Fluttertoast.showToast(msg: '${data["message"]}');ss

          print("Success: ${sendCoinData["message"]}");
        } else {
          Map<String, dynamic> errorData = jsonDecode(responsesendCoin.body);

          dialogBox.information(
              context, '${errorData['status']}', '${errorData["message"]}');
        }
      } else if (response.statusCode == 401) {
        Map<String, dynamic> errorData = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${errorData["message"]}');
        print("Error: ${errorData["message"]}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("OTP code validation failed. Error: $error");
      // Handle OTP code validation exception
    } finally {
      sendLoading(false);
    }
  }

  Future<void> addBankDetails(BuildContext context, String bankName,
      String accountNo, String accountName) async {
    setLoadingSend(true);
    notifyListeners();

    var token = user.token;
    var profileId = user.profileId;
    print("tokens:$token");
    print("profileId:$profileId");
    print("bankName:$bankName");
    print("accountNo:$accountNo");
    print("accountName:$accountName");

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';

    try {
      var response = await dio.post(
        '$baseUrl/Banks/add_bankdetails',
        data: {
          "bankName": bankName,
          "accountNo": accountNo,
          "accountName": accountName,
          "profileId": profileId,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoadingSend(false);
        Map<String, dynamic> userProfile = response.data;
        print("Sucess:$userProfile");
        final bankDetails = Provider.of<UserProvider>(context, listen: false);
        bankDetails.fetchBankDetails();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GetBankDetails(),
            ));
        Fluttertoast.showToast(msg: userProfile['message']);
      } else {
        setLoadingSend(false);
        Map<String, dynamic> userProfile = response.data;
        print("Error:$userProfile");
        Fluttertoast.showToast(msg: userProfile['message']);
      }
    } catch (e) {
      // Handle Dio errors (e.g., network issues)
      setLoadingSend(false);
      print('Dio Error: $e');
      Fluttertoast.showToast(msg: 'Network Error');
    }
  }

  Future<void> editBankDetails(BuildContext context, int bankDetailsId,
      String bankName, String accountNo, String accountName) async {
    setLoadingSend(true);
    notifyListeners();

    var token = user.token;
    var profileId = user.profileId;
    print("tokens:$token");
    print("profileId:$profileId");
    print("bankName:$bankName");
    print("accountNo:$accountNo");
    print("accountName:$accountName");

    var dio = Dio();
    dio.options.headers["Authorization"] = 'Bearer $token';

    try {
      var response = await dio.post(
        '$baseUrl/Banks/edit/$bankDetailsId',
        data: {
          "bankDetailsId": bankDetailsId,
          "bankName": bankName,
          "accountNo": accountNo,
          "accountName": accountName,
          "profileId": profileId,
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoadingSend(false);
        Map<String, dynamic> userProfile = response.data;
        print("Sucess:$userProfile");
        final bankDetails = Provider.of<UserProvider>(context, listen: false);
        bankDetails.fetchBankDetails();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GetBankDetails(),
            ));
        Fluttertoast.showToast(msg: userProfile['message']);
      } else {
        setLoadingSend(false);
        Map<String, dynamic> userProfile = response.data;
        print("Error:$userProfile");
        Fluttertoast.showToast(msg: userProfile['message']);
      }
    } catch (e) {
      setLoadingSend(false);
      // Handle Dio errors (e.g., network issues)
      print('Dio Error: $e');
      Fluttertoast.showToast(msg: 'Network Error');
    }
  }

  Future<void> fetchBankDetails() async {
    final token = user.token;
    final profileId = user.profileId;

    //print("p2pUserdatatoken$token");
    final url = Uri.parse('$baseUrl/Banks/get_user_banks?profileId=$profileId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      //print("_getBankData:$data");
      _getBankData = data.map((item) => item as Map<String, dynamic>).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch P2P Sell Ads');
    }
  }

  Future<void> deleteBankDetails(context, int bankDetailsId) async {
    setLoadingSend(true);
    notifyListeners();
    final token = user.token;
    final profileId = user.profileId;

    //print("p2pUserdatatoken$token");
    final url = Uri.parse('$baseUrl/Banks/delete/$bankDetailsId');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setLoadingSend(false);
      print("Error:$data");
      final bankDetails = Provider.of<UserProvider>(context, listen: false);
      bankDetails.fetchBankDetails();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GetBankDetails(),
          ));
      Fluttertoast.showToast(msg: data['message']);
      notifyListeners();
    } else {
      setLoadingSend(false);
      final Map<String, dynamic> data = json.decode(response.body);
      print("Error:$data");
      Fluttertoast.showToast(msg: data['message']);
    }
  }

  Future<void> saveProfile22(
      String change, String value, BuildContext context) async {
    try {
      setLoadingSend(true);
      notifyListeners();

      FormData formData = FormData();
      var tokens = user.token;
      var profileId = user.profileId;
      var firstName = getuser.firstName;
      var surname = getuser.surName;
      var email = user.email;
      var phone = getuser.phoneNumber;
      var middleName = getuser.middleName;
      var nickName = getuser.nickName;
      var aboutMe = getuser.aboutMe;
      var address = getuser.address;
      var dateOfBirth = getuser.dateOfBirth;
      var imageUrl = getuser.imageUrl;
      print('middleName:$middleName');
      print('change:$change');
      print('profileId:$profileId');
      print('tokens:$tokens');
      if (change == 'First Name') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': value,
          'SurName': surname,
          'MiddleName': middleName,
          'NickName': nickName,
          "AboutMe": aboutMe,
          "Address": address,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'Surname') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': value,
          'MiddleName': middleName,
          'NickName': nickName,
          "AboutMe": aboutMe,
          "Address": address,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'Middle Name') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': surname,
          'MiddleName': value,
          'NickName': nickName,
          "AboutMe": aboutMe,
          "Address": address,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'Nick Name') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': surname,
          'MiddleName': middleName,
          'NickName': value,
          "AboutMe": aboutMe,
          "Address": address,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'About Me') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': surname,
          'MiddleName': middleName,
          'NickName': nickName,
          'AboutMe': value,
          "Address": address,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'Address') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': surname,
          'MiddleName': middleName,
          'NickName': nickName,
          'AboutMe': address,
          'Address': value,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'Phone Number') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': surname,
          'MiddleName': middleName,
          'NickName': nickName,
          'AboutMe': aboutMe,
          'Address': address,
          'Email': email,
          'PhoneNumber': value,
          'dateOfBirth': dateOfBirth,
          'imageUrl': imageUrl
        });
      }
      if (change == 'DOB') {
        formData = FormData.fromMap({
          'ProfileId': profileId.toString(),
          'FirstName': firstName,
          'SurName': surname,
          'MiddleName': middleName,
          'NickName': nickName,
          'AboutMe': aboutMe,
          'Address': address,
          'Email': email,
          'PhoneNumber': phone,
          'dateOfBirth': value,
          'imageUrl': imageUrl
        });
      }

      dio.options.headers['Authorization'] = 'Bearer $tokens';

      var profileUrl = "$baseUrl/Profiles/edit/$profileId";

      final response = await dio.post(
        profileUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        Fluttertoast.showToast(msg: '${responseData['message']}');
        Map<String, dynamic> getProfile = responseData['profile'];
        ProfileUserModel profileUser = ProfileUserModel.fromJson(getProfile);
        Provider.of<UserProvider>(context, listen: false)
            .setUserprofile(profileUser);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewProfile(),
            ));
        setLoadingSend(false);
      } else {
        setLoadingSend(false);
        Map<String, dynamic> responseData = response.data;
        Fluttertoast.showToast(msg: '${responseData}');
      }
    } catch (error) {
      setLoadingSend(false);
      Fluttertoast.showToast(msg: 'Error: $error');
      print(" Error: $error");
      // Handle exceptions
    } finally {
      setLoadingSend(false);
    }
  }

  Future<void> saveProfile(
    context,
    firstName,
    surName,
    middleName,
    nickName,
    address,
    phoneNumber,
    dateOfBirth,
    aboutMe,
    File? imageFile,
  ) async {
    setLoadingSend(true);
    notifyListeners();
    var tokens = user.token;
    var profileId = user.profileId;
    var email = user.email;
    var url = "$baseUrl/Profiles/edit/$profileId";
    print("selectedImage:$imageFile");
    print("getuserImage:${getuser.imageUrl}");
    print("getuserImageFile:${getuser.imageFile}");

    try {
      FormData formData = FormData();
      formData.fields.addAll([
        MapEntry('ProfileId', profileId.toString()),
        MapEntry('FirstName', firstName),
        MapEntry('SurName', surName),
        MapEntry('Email', email!),
        MapEntry('PhoneNumber', phoneNumber),
        MapEntry('MiddleName', middleName),
        MapEntry('NickName', nickName),
        MapEntry('AboutMe', aboutMe),
        MapEntry('Address', address),
        MapEntry('DateOfBirth', dateOfBirth),
      ]);
      // Check if an image file is provided and add it to FormData
      if (imageFile != null) {
        formData.files.add(MapEntry(
          'ImageFile',
          await MultipartFile.fromFile(imageFile.path),
        ));
      } else if (getuser.imageUrl != null) {
        formData.fields.add(MapEntry(
          'ImageUrl',
          getuser.imageUrl!,
        ));
      } else {
        formData.fields.add(MapEntry(
          'ImageFile',
          getuser.imageFile!,
        ));
      }
      // FormData formData = FormData.fromMap({
      //   'ProfileId': profileId.toString(),
      //   'FirstName': firstName,
      //   'SurName': surName,
      //   'Email': email,
      //   'PhoneNumber': phoneNumber,
      //   'MiddleName': middleName,
      //   'NickName': nickName,
      //   'AboutMe': aboutMe,
      //   'Address': address,
      //   'ImageFile': imageFile != null
      //       ? await MultipartFile.fromFile(imageFile.path)
      //       : null,

      //   // 'ImageFile': await MultipartFile.fromFile(imageFile.path),
      //   // 'ImageFile': imageFile is File
      //   //     ? await MultipartFile.fromFile((imageFile as File).path)
      //   //     : getuser.imageFile,
      //   'dateOfBirth': dateOfBirth,
      // });

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $tokens';

      var response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        Fluttertoast.showToast(msg: '${responseData['message']}');

        // Update the imageUrl in the existing ProfileUserModel
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        ProfileUserModel existingProfile = userProvider.getuser;
        existingProfile = ProfileUserModel(
          profileId: getuser.profileId,
          firstName: responseData['profile']['firstName'],
          surName: responseData['profile']['surName'],
          email: getuser.email,
          phoneNumber: responseData['profile']['phoneNumber'],
          middleName: responseData['profile']['middleName'],
          nickName: responseData['profile']['nickName'],
          aboutMe: responseData['profile']['aboutMe'],
          address: responseData['profile']['address'],
          dateOfBirth: responseData['profile']['dateOfBirth'],
          imageUrl: responseData['profile']
              ['imageUrl'], // Replace imageUrl with the new value
        );

        // Set the updated ProfileUserModel back in the UserProvider
        userProvider.setUserprofile(existingProfile);

        setLoadingSend(false);
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewProfile(),
          ),
        );
      } else {
        setLoadingSend(false);
        notifyListeners();
        Map<String, dynamic> responseData = response.data;
        Fluttertoast.showToast(msg: '${responseData['message']}');
      }
    } catch (error) {
      setLoadingSend(false);
      Fluttertoast.showToast(msg: 'Server Error');

      // Handle exceptions
      print('Error uploading image: $error');
    }
  }
}
