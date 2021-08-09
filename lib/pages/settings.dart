import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/drawer.dart';
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
      appBar: AppBar(centerTitle: true, title: Text('Settings'), actions: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: Icon(Icons.menu),
          ).px(16),
        ),
      ]),
      endDrawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDrawerRowEntryWithoutIcon(
                    title: 'Application', onTap: () {}),
                16.heightBox,
                Text(
                  'GLOBAL SETTINGS',
                  style: _drawerTitleText,
                ).py(16),
                buildDrawerRowEntryWithoutIcon(
                    title: 'Internationalization', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(
                    title: 'Media Library', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(title: 'Webhooks', onTap: () {}),
                16.heightBox,
                Text(
                  'ADMINISTRATION PANEL',
                  style: _drawerTitleText,
                ).py(16),
                buildDrawerRowEntryWithoutIcon(title: 'Roles', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(title: 'Users', onTap: () {}),
                16.heightBox,
                Text(
                  'USERS & PERMISSONS PLUGIN',
                  style: _drawerTitleText,
                ).py(16),
                buildDrawerRowEntryWithoutIcon(title: 'Roles', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(
                    title: 'Providers', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(title: 'Email', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(title: 'Template', onTap: () {}),
                buildDrawerRowEntryWithoutIcon(title: 'Settings', onTap: () {}),
                16.heightBox,
                Text(
                  'EMAIL PLUGIN',
                  style: _drawerTitleText,
                ).py(16),
                buildDrawerRowEntryWithoutIcon(
                    title: 'Email Settings', onTap: () {}),
              ],
            ).p(16),
          ),
        ),
      ),
    );
  }

  TextStyle _drawerTitleText =
      TextStyle(color: neutral600, fontSize: 15, fontWeight: FontWeight.bold);
}
