import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/bookings_list.dart';
import 'package:strapi_flutter_cms/pages/login.dart';
import 'package:strapi_flutter_cms/pages/media_library_page.dart';
import 'package:strapi_flutter_cms/pages/splash_screen.dart';
import 'package:strapi_flutter_cms/pages/training_videos_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: strapiColor,
          appBarTheme: AppBarTheme(
            color: strapiColor,
          )),
      debugShowCheckedModeBanner: false,
      home: MediaLibraryPage(),
    );
  }
}
