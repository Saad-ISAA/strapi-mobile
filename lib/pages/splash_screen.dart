import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/pages/home_page.dart';
import 'package:strapi_flutter_cms/pages/login.dart';
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

  void _checkUserIsLoggedIn() {
    String user = GlobalConfig.prefs.getString("user");

    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Opacity(
          opacity: _animation.value,
          child: Image.asset(
            'assets/images/strapi_new.png',
            height: context.percentWidth * 30,
          ),
        ),
      ),
    );
  }
}
