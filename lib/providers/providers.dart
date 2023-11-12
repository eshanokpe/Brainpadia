import 'dart:async';
import 'dart:convert';
import 'package:brainepadia/Screens/Login/login_screen.dart';
import 'package:brainepadia/Screens/Otp/otp_verification.dart';
import 'package:brainepadia/Screens/Resetpassword/resetpassword_screen.dart';
import 'package:brainepadia/Screens/Verification/verification_screen.dart';
import 'package:brainepadia/models/user.dart';
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

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<void> deleteAuthToken() async {
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
  bool isLoading = false;

  String token = '';
  User userDetails = User();
  ProfileUserModel profileDetails = ProfileUserModel();
  WalletModel walletDetails = WalletModel();
  List transactionDetails = [];
  int? getbalance;
  var getDollarbalance;
  int? getNaijabalance;
  Map transactionDetailsdata = {};

  Future<void> login(BuildContext context) async {
    try {
      var result;
      setLoading(true);
      notifyListeners();

      // Ensure _prefs is fully initialized

      if (email == null || password == null) {
        // Show validation error message
        Fluttertoast.showToast(msg: 'FIll up all fields');
        return;
      }
      var loginUrl = Uri.parse(APIEndpoints.authLogin);
      // Create JSON payload for login request
      var payload = jsonEncode(
          {"email": email, "password": password, "rememberMe": true});
      _loggedInStatus = Status.Authenticating;
      notifyListeners();
      // Send login request
      var response = await http.post(loginUrl,
          headers: {"Content-Type": "application/json"}, body: payload);
      // Handle login response
      if (response.statusCode == 200) {
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        var message = userProfile["response"]["message"];
        var authToken = userProfile["userProfile"]["token"];
        Fluttertoast.showToast(msg: '$message!');
        //await setAuthToken(authToken);
        // var authToken = jsonDecode(response.body)["response"]["message"];
        // print("Login successful!: ${authToken} ");
        // Store the auth token for future API requests
        //User authUser = User.fromJson(userProfile['userProfile']);
        User authUser = User.fromJson(userProfile['userProfile']);
        UserPreferences().saveUser(authUser);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
        Provider.of<UserProvider>(context, listen: false).setUser(authUser);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ));
      } else if (response.statusCode == 401) {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        result = userProfile['message'];
        Fluttertoast.showToast(msg: '${userProfile['message']}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('otpemail', email!);
        print("Login failed. Error: ${response.body}");
        print("${response.statusCode}");
        if (userProfile['message'] != 'Invalid Login Attempt') {
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
        notifyListeners();
        Map<String, dynamic> userProfile = jsonDecode(response.body);
        Fluttertoast.showToast(msg: '${userProfile['message']}');
        result = userProfile['message'];
        print("Login failed. Error: ${response.body}");
        print("${response.statusCode}");
        // Handle login failure
      }
      return result;
    } catch (error) {
      Fluttertoast.showToast(msg: 'Login failed. Error: $error');

      print("Login failed. Error: $error");
      // Handle login exception
    } finally {
      setLoading(false);
    }
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
