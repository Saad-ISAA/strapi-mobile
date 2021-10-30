import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/settings_end_drawer.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/application_settings.dart';
import 'package:strapi_flutter_cms/shared/settings_drawer_items.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<_SettingsPageState> _scaffoldKey = GlobalKey();

  Widget selectedPage = ApplicationSettingsPage();

  SettingsDrawerItem activatedTab = SettingsDrawerItem.APPLICATION;

  void _setSelectedPage(Widget page) {
    setState(() {
      selectedPage = page;
      Navigator.pop(context);
    });
  }

  void _setActivatedTab(SettingsDrawerItem newValue) {
    setState(() {
      activatedTab = newValue;
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
      endDrawer:
          buildSettingsDrawer(_setSelectedPage, activatedTab, _setActivatedTab),
      body: selectedPage,
    );
  }
}

void demo() {}
