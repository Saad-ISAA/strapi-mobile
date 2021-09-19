import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String token;
  String adminURL;
  Map<String, dynamic> user;

  UserData({this.adminURL, this.token, this.user});
}

class GlobalConfig {
  static SharedPreferences prefs;
  static UserData data;
  static initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    var user = prefs.getString("user");
    var token = prefs.getString("token");
    var adminURL = prefs.getString("adminURL");

    if (user != null) {
      data = new UserData(
          user: jsonDecode(user), token: token, adminURL: adminURL);
    }
  }
}
