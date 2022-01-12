import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/controllers/collectionTypeController.dart';
import 'package:strapi_flutter_cms/models/content_type.dart';
import 'package:strapi_flutter_cms/pages/IntroductryPage.dart';
import 'package:strapi_flutter_cms/pages/dashboard_v4.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContentType> contentTypes = [];

  void initState() {
    super.initState();
    fetchContentTypes().then((value) {
      print(value);
      setState(() {
        // print("content types fetched" + value.length.toString());
        contentTypes = value;
      });
    }).catchError((err) {
      print(err);
      print("caught errorrr");
    }).whenComplete(() => null);
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
        contentTypes: contentTypes,
      ),
      body: Dashboard(),
    );
  }
}
