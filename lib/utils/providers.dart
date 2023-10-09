import 'package:brainepadia/models/loginusermodel.dart';
import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  String token = '';
  Loginusermodel loginDetails = Loginusermodel();

  setLoginDetails(Loginusermodel details) {
    loginDetails = details;
    notifyListeners();
  }

  seToken(String finalToken) {
    token = finalToken;
    notifyListeners();
  }
}
