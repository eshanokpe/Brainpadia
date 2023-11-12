import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late SharedPreferences _prefs;
  //final prefs = await SharedPreferences.getInstance();
  final String _authTokenKey = 'authToken';
  

  String? getAuthToken() {
    return _prefs.getString(_authTokenKey);
  }

  Future<void> setAuthToken(String authToken) async {
    await _prefs.setString(_authTokenKey, authToken);
  }

  Future<void> deleteAuthToken() async {
    await _prefs.remove(_authTokenKey);
  }
}
