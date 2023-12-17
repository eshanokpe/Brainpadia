import 'dart:async';
import 'dart:convert';
import 'package:brainepadia/Screens/Login/login_screen.dart';
import 'package:brainepadia/Screens/Otp/otp_verification.dart';
import 'package:brainepadia/Screens/Resetpassword/resetpassword_screen.dart';
import 'package:brainepadia/Screens/Verification/verification_screen.dart';
import 'package:brainepadia/Screens/dashboard/Send/components/send_success.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/utilis/dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/dashboard/dashboard.dart';
import '../utilis/constants.dart';
import '../utilis/shared_preference.dart';
import 'P2PPostAdsProvider.dart';
import 'fetchBlockchain.dart';
import 'user_provider.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class Providers extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  final Status _registeredInStatus = Status.NotRegistered;
  DialogBox dialogBox = DialogBox();

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool _isConPasswordVisible = false;
  bool get isConPasswordVisible => _isConPasswordVisible;

  void toggleConPasswordVisibility() {
    _isConPasswordVisible = !_isConPasswordVisible;
    notifyListeners();
  }

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<void> deleteAuthToken() async {
    UserPreferences().removeUser();
    UserPreferences().removeUser();
    UserPreferences().removeUser();
  }

  String? firstname;
  String? lastname;
  String? phonenumber;
  String? email;
  String? password;
  String? conpassword;
  String? emailotp;
  String? otpCodeotp;
  String? otpCode;
  double? _balance = 0.0;
  bool isLoading = false;
  bool _isLoadingSend = false;
  bool get isLoadingSend => _isLoadingSend;
  bool getLoading = false;

  double? get balance => _balance;
  String token = '';
  User userDetails = User();
  ProfileUserModel profileDetails = ProfileUserModel();
  WalletModel walletDetails = WalletModel();
  int? getbalance;
  String? sendAmount;

  Future<void> login(BuildContext context) async {
    try {
      setLoading(true);

      if (email == null || password == null) {
        Fluttertoast.showToast(msg: 'FIll up all fields');
        return;
      }
      var loginUrl = Uri.parse(APIEndpoints.authLogin);
      var payload = jsonEncode(
          {"email": email, "password": password, "rememberMe": true});
      _loggedInStatus = Status.Authenticating;

      var response = await http.post(loginUrl,
          headers: {"Content-Type": "application/json"}, body: payload);
      // Handle login response
      print(response.statusCode);
      if (response.statusCode == 200) { 
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        var message = userProfile["response"]["message"];
        int profileId = userProfile['userProfile']['profileId'];
        var token = userProfile['userProfile']['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        var tokens = await prefs.setString('token', token!);

        print("profileId:$profileId");
        print("token:$tokens");
        await fetchProfileAndWallet(token, profileId, context);
        var walletAddress = Provider.of<UserProvider>(context, listen: false)
            .getuserWallet
            .walletAddress;

        var getBalanceurl = Uri.parse(
            "$baseUrl/BPCoin/get_balance_by_address?userAddress=$walletAddress");
        var getBalanceresponse = await http
            .get(getBalanceurl, headers: {"Authorization": 'Bearer $token'});
        final responseData = json.decode(getBalanceresponse.body);
        dynamic balance = responseData['data'];
        print('balance:$balance');
        if (balance is int) {
          _balance = balance.toDouble(); // Convert int to double
        } else if (balance is double) {
          _balance = balance.toDouble(); // Use directly without conversion
        } else {
          throw Exception('Get balance not available');
        }

        // print('_balance:${_balance!.toDouble()}');

        User authUser = User.fromJson(userProfile['userProfile']);
        // Set the user and save it
        Provider.of<FetchBlockchain>(context, listen: false).setUser(authUser);
        Provider.of<P2PPostAdsProvider>(context, listen: false)
            .setUser(authUser);
        UserPreferences().saveUser(authUser);

        _loggedInStatus = Status.LoggedIn;

        Provider.of<UserProvider>(context, listen: false).setUser(authUser);
        final p2pAdsProvider =
            Provider.of<P2PPostAdsProvider>(context, listen: false);
        p2pAdsProvider.fetchP2PUserBuyAds();
        p2pAdsProvider.fetchP2PUserSellAds();
        p2pAdsProvider.fetchP2PBuyAds();
        p2pAdsProvider.fetchP2PSellAds();

        setLoading(false);
        notifyListeners();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ));
        Fluttertoast.showToast(msg: '$message!');
      } else if (response.statusCode == 401) {
        _loggedInStatus = Status.NotLoggedIn;

        Map<String, dynamic> userProfile = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${userProfile['message']}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('otpemail', email!);
        print("${response.statusCode}");
        print("Login failed. Error: ${userProfile}");
        print("Login failed. Error: ${response.body}");

        if (userProfile['message'] == 'User Not Found') {
          setLoading(false);
          notifyListeners();
          return;
        }
        if (userProfile['message'] != 'Invalid Login Attempt') {
          setLoading(false);
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const OTPVerificationScreen();
              },
            ),
          );
        }
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        setLoading(false);
        notifyListeners();
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${userProfile['message']}');

        print("Login failed. Error: ${response.body}");
        print("${response.statusCode}");
        // Handle login failure
      }
    } catch (error) {
      setLoading(false);
      notifyListeners();
      Fluttertoast.showToast(msg: 'Login failed. Error: $error');

      print("Login failed. Error: $error");
      // Handle login exception
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> fetchProfileAndWallet(
      String token, int profileId, context) async {
    var profileIdUrl =
        Uri.parse(APIEndpoints.getProfile + profileId.toString());
    var getWalletUrl =
        Uri.parse("$baseUrl/Profiles/get_wallet?profileId=$profileId");

    var responseProfile =
        http.get(profileIdUrl, headers: {"Authorization": 'Bearer $token'});
    var responseWallet =
        http.get(getWalletUrl, headers: {"Authorization": 'Bearer $token'});

    var responses = await Future.wait([responseProfile, responseWallet]);

    Map<String, dynamic> getProfile = jsonDecode(responses[0].body);
    ProfileUserModel profileUser = ProfileUserModel.fromJson(getProfile);
    //UserPreferences().saveUserprofile(profileUser);

    Map<String, dynamic> getWallet = jsonDecode(responses[1].body);
    WalletModel userWallet = WalletModel.fromJson(getWallet);

    // UserPreferences().userWallet(userWallet);
    // Set the user profile and wallet
    // Provider.of<FetchBlockchain>(context, listen: false)
    //     .setUserprofile(profileUser);
    Provider.of<UserProvider>(context, listen: false)
        .setUserprofile(profileUser);
    Provider.of<UserProvider>(context, listen: false).setUserwallet(userWallet);
  }

  Future<void> signUp(BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();
      // Perform validation
      if (firstname == null ||
          lastname == null ||
          phonenumber == null ||
          email == null ||
          password == null ||
          conpassword == null) {
        // Show validation error message
        Fluttertoast.showToast(msg: 'FIll up all fields');
        return;
      }
      if (password != conpassword) {
        // Show validation error message
        Fluttertoast.showToast(msg: 'Incorrect Password');
        return;
      }
      var signUpUrl = Uri.parse(APIEndpoints.register);
      // Create JSON payload for sign up request
      var payload = jsonEncode({
        "firstName": firstname,
        "lastName": lastname,
        "phoneNumber": phonenumber,
        "email": email,
        "password": password,
        "confirmPassword": conpassword
      });

      // Send sign up request
      var response = await http.post(signUpUrl,
          headers: {"Content-Type": "application/json"}, body: payload);
      // Handle sign up response

      if (response.statusCode == 200) {
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        print("Sign up successful!");
        Fluttertoast.showToast(msg: 'Sign up successful!');
        // Save the email in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('otpemail', email!);

        //For example, navigate to OTP code entry page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationScreen(),
          ),
        );
      } else {
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${userProfile['message']}');
        print("Sign up failed. Error: ${response.body}");
        // Handle sign up failure
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Internal Server Error');
      print("Signup failed. Error: $error");
      // Handle login exception
    } finally {
      setLoading(false);
    }
  }

  Future<void> validateOTPCode(BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? otpemail = prefs.getString('otpemail');
      print("email:$otpemail");
      print("otpCode:$otpCodeotp");
      var validateOTPUrl = Uri.parse(APIEndpoints.postOTP);
      // Create JSON payload for OTP code validation request
      var payload = jsonEncode({
        "email": otpemail,
        "otp": otpCodeotp,
      });
      // Send OTP code validation request
      var response = await http.post(validateOTPUrl,
          headers: {"Content-Type": "application/json"}, body: payload);
      print("${response.statusCode}");
      // Handle OTP code validation response
      if (response.statusCode == 200) {
        prefs.remove('otpemail');
        Fluttertoast.showToast(msg: 'OTP code validation successful!');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else if (response.statusCode == 400) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        setLoading(false);

        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');

        print("OTP code validation failed. Error: ${response.body}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("OTP code validation failed. Error: $error");
      // Handle OTP code validation exception
    } finally {
      setLoading(false);
    }
  }

  Future<void> resendOTPCode(BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? otpemail = prefs.getString('otpemail');
      print("email:$otpemail");
      var validateOTPUrl =
          Uri.parse("$baseUrl/Account/resend_otp?email=$otpemail");
      // Create JSON payload for OTP code validation request

      // Send OTP code validation request
      var response = await http
          .get(validateOTPUrl, headers: {"Content-Type": "application/json"});
      print("${response.statusCode}");
      // Handle OTP code validation response
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'OTP code Send successful!');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationScreen(),
          ),
        );
      } else if (response.statusCode == 400) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationScreen(),
          ),
        );
      } else {
        setLoading(false);
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');

        print("OTP code validation failed. Error: ${response.body}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("OTP code validation failed. Error: $error");
      // Handle OTP code validation exception
    } finally {
      setLoading(false);
    }
  }

  Future<void> forgetpasswordReset(BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('useremail', email!);
      print("useremail:$email");

      var passwordResetUrl =
          Uri.parse("$baseUrl/Account/forgot_password?email=$email");
      // Create JSON payload for OTP code validation request

      // Send OTP code validation request
      var response = await http
          .get(passwordResetUrl, headers: {"Content-Type": "application/json"});
      print("${response.statusCode}");
      // Handle OTP code validation response
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetpasswordScreen(),
          ),
        );
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');

        print("OTP code validation failed. Error: ${response.body}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("OTP code validation failed. Error: $error");
      // Handle OTP code validation exception
    } finally {
      setLoading(false);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();
      if (password != conpassword) {
        // Show validation error message
        Fluttertoast.showToast(msg: 'Incorrect Password');
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? useremail = prefs.getString('useremail');
      print("useremail:$useremail");
      var passwordResetUrl = Uri.parse(APIEndpoints.passwordReset);
      // Create JSON payload for OTP code validation request
      var payload = jsonEncode({
        "password": password,
        "confirmPassword": conpassword,
        "email": useremail,
        "otp": otpCodeotp,
      });
      // Send OTP code validation request
      var response = await http.post(passwordResetUrl,
          headers: {"Content-Type": "application/json"}, body: payload);
      print("${response.statusCode}");
      // Handle OTP code validation response
      if (response.statusCode == 200) {
        // Remove data for the 'counter' key.
        await prefs.remove('useremail');
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');

        print("OTP code validation failed. Error: ${response.body}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("OTP code validation failed. Error: $error");
      // Handle OTP code validation exception
    } finally {
      setLoading(false);
    }
  }

  Future<String> fetchProfileFee(int amount, BuildContext context) async {
    var feeUrl = Uri.parse("$baseUrl/BPCoin/get_fee?amount=$amount");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokens = prefs.getString('token');
    var response =
        await http.get(feeUrl, headers: {"Authorization": 'Bearer $tokens'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('data:$data');
      Provider.of<UserProvider>(context, listen: false).fetchFee(data);

      return data.toString();
    } else {
      throw Exception('Failed to fetch profile fee');
    }
  }

  Future<void> sendOTP(String email, BuildContext context) async {
    try {
      setLoading(true);
      notifyListeners();
      var feeUrl = Uri.parse("$baseUrl/Account/resend_otp?email=$email");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var tokens = prefs.getString('token');
      var response =
          await http.get(feeUrl, headers: {"Authorization": 'Bearer $tokens'});

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data["message"]}');
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${data}');
        //throw Exception('Failed $data');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error: $error');
      print("OTP code validation failed. Error: $error");
      // Handle OTP code validation exception
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    await deleteAuthToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void setFirstname(String value) {
    firstname = value;
    notifyListeners();
  }

  void setLastname(String value) {
    lastname = value;
    notifyListeners();
  }

  void setPhonenumber(String value) {
    phonenumber = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setConpassword(String value) {
    conpassword = value;
    notifyListeners();
  }

  void setOTPCode(String otpCode) {
    // emailotp = email;
    otpCodeotp = otpCode;
    notifyListeners();
  }

  void setOTPCodereset(String otpCode) {
    otpCodeotp = otpCode;
    notifyListeners();
  }

  void setResendOTPCode(String email) {
    emailotp = email;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setLoadingSend(bool value) {
    _isLoadingSend = value;
    notifyListeners();
  }

  void setgetLoading(bool value) {
    getLoading = value;
    notifyListeners();
  }

  setLoginDetails(User details) {
    userDetails = details;
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

  getOTPCode(String email, String otpCode) {
    emailotp = email;
    otpCodeotp = otpCode;
    notifyListeners();
  }

  seToken(String finalToken) {
    token = finalToken;
    notifyListeners();
  }

  void setAmount(String value) {
    sendAmount = value;
    notifyListeners();
  }
}
