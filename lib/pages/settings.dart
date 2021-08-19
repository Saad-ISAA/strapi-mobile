import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/roles.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/drawer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'settings_pages/advanced_settings.dart';

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
      endDrawer: _buildSettingsDrawer(),
      body: AdvancedSettingsScreen(),
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

class MediaLibrarySettingsPage extends StatefulWidget {
  const MediaLibrarySettingsPage({Key key}) : super(key: key);

  @override
  State<MediaLibrarySettingsPage> createState() =>
      _MediaLibrarySettingsPageState();
}

class _MediaLibrarySettingsPageState extends State<MediaLibrarySettingsPage> {
  bool _responsiveFriendlyUpload;
  bool _sizeOptimization;
  bool _autoOrientation;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Media Library - Settings'.text.xl2.semiBold.make(),
          2.heightBox,
          'Configure the settings for media library'
              .text
              .medium
              .color(neutral500)
              .make(),
          16.heightBox,
          Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'IMAGE'.text.color(neutral500).make(),
                24.heightBox,
                Text('Enable responsive friendly upload',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                StrapiSwitch(
                  val: _responsiveFriendlyUpload,
                  onOffPress: () {
                    setState(() {
                      _responsiveFriendlyUpload = false;
                    });
                  },
                  onOnPress: () {
                    setState(() {
                      _responsiveFriendlyUpload = true;
                    });
                  },
                ),
                'It automatically generates size variants of the uploaded asset.'
                    .text
                    .size(14)
                    .color(neutral400)
                    .make(),
                24.heightBox,
                Text('Enable size optimization (without quality loss)',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                StrapiSwitch(
                  val: _sizeOptimization,
                  onOffPress: () {
                    setState(() {
                      _sizeOptimization = false;
                    });
                  },
                  onOnPress: () {
                    setState(() {
                      _sizeOptimization = true;
                    });
                  },
                ),
                24.heightBox,
                Text('Enable auto orientation',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                StrapiSwitch(
                  val: _autoOrientation,
                  onOffPress: () {
                    setState(() {
                      _autoOrientation = false;
                    });
                  },
                  onOnPress: () {
                    setState(() {
                      _autoOrientation = true;
                    });
                  },
                ),
                'Automatically rotate image according to EXIF tag.'
                    .text
                    .size(14)
                    .color(neutral400)
                    .make(),
              ],
            ).p(16),
          ),
          Spacer(),
          PrimarySquareButton(
            color: success500,
            text: 'Save',
          ),
          PrimaryCancelGreySquareButton(
            onPressed: () {},
          )
        ],
      ).p(24),
    );
  }
}
