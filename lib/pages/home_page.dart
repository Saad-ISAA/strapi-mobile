import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/blogs.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Main Page'),
          backgroundColor: strapiColor,
          centerTitle: true,
        ),
        drawer: CustomDrawer(
          drawerData: widget.drawerData,
          user: widget.user,
        ),
        body: BlogPage(),
      ),
    );
  }
}
