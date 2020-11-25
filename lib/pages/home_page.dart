import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:strapi_flutter_cms/pages/bookings_list.dart';
import 'package:strapi_flutter_cms/pages/training_videos_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(drawer: getDrawer(context), body: BookingsList()),
    );
  }
}
