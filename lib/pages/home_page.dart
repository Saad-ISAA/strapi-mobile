import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/IntroductryPage.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({this.drawerData, this.user});
  final List<dynamic> drawerData;
  final Map user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_white.png',
              height: 15,
            ),
            SizedBox(width: 8),
            Text(
              'strapi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
          ],
        ),
        backgroundColor: strapiColor,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        drawerData: widget.drawerData,
        user: widget.user,
      ),
      body: IntroductoryPage(user: widget.user),
    );
  }
}
