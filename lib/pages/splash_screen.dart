import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strapi_flutter_cms/pages/home_page.dart';
import 'package:strapi_flutter_cms/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String adminURL;
  @override
  void initState() {
    super.initState();

    _checkUserIsLoggedIn();
  }

  void _checkUserIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (prefs.containsKey('adminURL')) {
      adminURL = prefs.getString('adminURL');
    }

    if (prefs.containsKey("token")) {
      Map user = json.decode(prefs.getString('user'));

      List<dynamic> drawerData = await _getDrawerData(token, adminURL);

      if (drawerData != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      drawerData: drawerData,
                      user: user,
                    )));
      } else {
        print('login failed');
      }
    } else {
      Future.delayed(const Duration(milliseconds: 2500), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(adminURL: adminURL)));
      });
    }
  }

  Future<List> _getDrawerData(String token, String adminURL) async {
    var url = Uri.parse('https://$adminURL/content-manager/content-types');
    var response = await http.get(
      url,
      headers: {"Authorization": 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['data'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8A67F3), Color(0xFF1C1B7E)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 135,
        ),
      ),
    );
  }
}
