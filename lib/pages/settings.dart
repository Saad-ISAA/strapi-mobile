import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/settings_end_drawer.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/email_templates.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/providers.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<_SettingsPageState> _scaffoldKey = GlobalKey();

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
      endDrawer: buildSettingsDrawer(),
      body: ProvidersSettings(),
    );
  }
}
