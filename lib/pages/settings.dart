import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
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
      endDrawer: _buildSettingsDrawer(),
      body: Internationalization(),
    );
  }

  Drawer _buildSettingsDrawer() {
    return Drawer(
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
              buildDrawerRowEntryWithoutIcon(title: 'Providers', onTap: () {}),
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
    );
  }

  TextStyle _drawerTitleText =
      TextStyle(color: neutral600, fontSize: 15, fontWeight: FontWeight.bold);
}

class Internationalization extends StatelessWidget {
  const Internationalization({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '1 Locale'.text.xl3.semiBold.make().px(16),
                  24.heightBox,
                  LocaleRow(
                    code: 'en',
                    name: 'English(en)',
                    isDefault: true,
                  ),
                ],
              ).pOnly(top: 16)),
          Spacer(),
          PrimarySquareButton(
            color: blue,
            text: '+ Add Locale',
          )
        ],
      ).p(24),
    );
  }
}

class LocaleRow extends StatelessWidget {
  const LocaleRow({Key key, this.code, this.name, this.isDefault})
      : super(key: key);

  final String code;
  final String name;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAddLocaleDialog(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          code.text.lg.make(),
          name.text.lg.make(),
          (isDefault) ? 'Default Locale'.text.lg.make() : SizedBox.shrink(),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/edit.svg',
              height: 10,
            ),
          )
        ],
      ).p(16),
    );
  }
}
