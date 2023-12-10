import 'package:brainepadia/models/profileusermodel.dart';
import 'package:brainepadia/models/user.dart';
import 'package:brainepadia/models/walletmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {

  Future userWallet(WalletModel getWallet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("walletId", getWallet.walletId!);
    prefs.setInt("amount", getWallet.amount!);
    prefs.setString("walletType", getWallet.walletType!);
    prefs.setString("walletAddress", getWallet.walletAddress!);
    prefs.setString("publicKey", getWallet.publicKey!);
    prefs.setInt("secretNumber", getWallet.secretNumber!);
    prefs.setInt("profileId", getWallet.profileId!);
    prefs.setString("profile", getWallet.profile!);
    prefs.setString("dateCreated", getWallet.dateCreated!);
    prefs.setString("userCreated", getWallet.userCreated!);
    prefs.setString("dateModified", getWallet.dateModified!);
    prefs.setString("userModified", getWallet.userModified!);
  }

  Future saveUserprofile(ProfileUserModel userprofile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("profileId", userprofile.profileId!);
    prefs.setString("firstName", userprofile.firstName!);
    prefs.setString("surName", userprofile.surName!);
    prefs.setString("middleName", userprofile.middleName!);
    prefs.setString("nickName", userprofile.nickName!);
    prefs.setString("aboutMe", userprofile.aboutMe!);
    prefs.setString("address", userprofile.address!);
    prefs.setString("email", userprofile.email!);
    prefs.setString("phoneNumber", userprofile.phoneNumber!);
    prefs.setInt("projectCompleted", userprofile.projectCompleted!);
    prefs.setInt("freeLance", userprofile.freeLance!);
    prefs.setString("profession", userprofile.profession!);
    prefs.setString("gender", userprofile.gender!);
    prefs.setString("imageUrl", userprofile.imageUrl!);
    prefs.setString("imageFile", userprofile.imageFile!);
    prefs.setString("country", userprofile.country!);
    prefs.setString("state", userprofile.state!);
    prefs.setString("city", userprofile.city!);
    prefs.setString("dateOfBirth", userprofile.dateOfBirth!);
    prefs.setString("youtube", userprofile.youtube!);
    prefs.setString("facebook", userprofile.facebook!);
    prefs.setString("linkedIn", userprofile.linkedIn!);
    prefs.setString("github", userprofile.github!);
    prefs.setBool("isBlogger", userprofile.isBlogger!);
    prefs.setString("fullName", userprofile.fullName!);
    prefs.setString("twitter", userprofile.twitter!);
    prefs.setString("dateCreated", userprofile.dateCreated!);
    prefs.setString("userCreated", userprofile.userCreated!);
    prefs.setString("dateModified", userprofile.dateModified!);
    prefs.setString("userModified", userprofile.userModified!);

    //print(userprofile.fullName);
  }

  Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userId", user.userId!);
    prefs.setString("firstName", user.firstName!);
    prefs.setString("lastName", user.lastName!);
    prefs.setString("email", user.email!);
    prefs.setString("phoneNumber", user.phoneNumber!);
    prefs.setInt("profileId", user.profileId!);
    prefs.setString("token", user.token!);
    prefs.setString("tokenExpiration", user.tokenExpiration!);

    print(user.token);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString("userId");
    String? firstName = prefs.getString("firstName");
    String? lastName = prefs.getString("lastName");
    String? email = prefs.getString("email");
    String? phoneNumber = prefs.getString("phoneNumber");
    int? profileId = prefs.getInt("profileId");
    String? token = prefs.getString("token");
    String? tokenExpiration = prefs.getString("tokenExpiration");

    return User(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        profileId: profileId,
        token: token,
        tokenExpiration: tokenExpiration);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("firstName");
    prefs.remove("lastName");
    prefs.remove("email");
    prefs.remove("phoneNumber");
    prefs.remove("profileId");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }
}
