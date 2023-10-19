import 'package:brainepadia/models/loginusermodel.dart';
import 'package:brainepadia/models/profileusermodel.dart';
import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  String token = '';
  Loginusermodel loginDetails = Loginusermodel();
  ProfileUserModel profileDetails = ProfileUserModel();
  //Map profileDetails = {};

  setLoginDetails(Loginusermodel details) {
    loginDetails = details;
    notifyListeners();
  }

  setProfile(ProfileUserModel profile) {
    profileDetails = profile;
    notifyListeners();
  }

  // setProfile(Map profile) {
  //   profileDetails = profile;
  //   notifyListeners();
  // }

  seToken(String finalToken) {
    token = finalToken;
    notifyListeners();
  }
}
