import 'package:brainepadia/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
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

    print("object prefere");
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
