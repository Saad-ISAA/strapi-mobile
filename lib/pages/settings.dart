import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/settings_end_drawer.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/application_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/email_templates.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/media_library_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/providers.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/roles.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<_SettingsPageState> _scaffoldKey = GlobalKey();

  Widget selectedPage = ApplicationSettingsPage();

  void _setSelectedPage(Widget page) {
    setState(() {
      selectedPage = page;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text('Settings'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(Icons.menu),
              ).px(16),
            ),
          ]),
      endDrawer: buildSettingsDrawer(_setSelectedPage),
      body: selectedPage,
    );
  }
}
