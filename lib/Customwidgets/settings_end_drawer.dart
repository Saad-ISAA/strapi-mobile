import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Drawer buildSettingsDrawer() {
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDrawerRowEntryWithoutIcon(title: 'Application', onTap: () {}),
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

Widget buildDrawerRowEntryWithoutIcon({String title, Function onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Row(
        children: [
          Container(
              height: 9,
              width: 9,
              decoration:
                  BoxDecoration(color: neutral500, shape: BoxShape.circle)),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15, color: drawerRowsColor),
          )
        ],
      ),
    ),
  );
}
