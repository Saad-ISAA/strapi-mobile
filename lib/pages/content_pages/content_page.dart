import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/content_page_end_drawer.dart';
import 'package:velocity_x/velocity_x.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  GlobalKey<_ContentPageState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text('Content'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(Icons.menu),
              ).px(16),
            ),
          ]),
      endDrawer: buildContentDrawer(),
      body: Container(),
    );
  }
}
