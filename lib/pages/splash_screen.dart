import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strapi_flutter_cms/pages/home_page.dart';
import 'package:strapi_flutter_cms/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  _animateLogo() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  String adminURL;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    _animateLogo();

    Future.delayed(const Duration(milliseconds: 2500), () {
      _checkUserIsLoggedIn();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(adminURL: adminURL)));
    }
  }

  Future<List> _getDrawerData(String token, String adminURL) async {
    var url = Uri.parse('$adminURL/content-manager/content-types');
    print(adminURL);
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
        color: Colors.white,
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          opacity: _animation,
          height: context.percentWidth * 30,
        ),
      ),
    );
  }
}
