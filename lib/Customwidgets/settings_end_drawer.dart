import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/comming_soon_page.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/advanced_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/application_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/email_templates.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/internationalization.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/media_library_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/providers.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/roles.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/messages.dart';
import 'package:velocity_x/velocity_x.dart';

Drawer buildSettingsDrawer(Function(Widget) setSelectedPage) {
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Settings'.text.xl3.bold.make().p(10),
            buildDrawerRowEntryWithoutIcon(
                title: 'Application',
                onTap: () {
                  setSelectedPage(ApplicationSettingsPage());
                }),
            16.heightBox,
            Text(
              'GLOBAL SETTINGS',
              style: _drawerTitleText,
            ).py(16),
            buildDrawerRowEntryWithoutIcon(
                title: 'Internationalization',
                onTap: () {
                  setSelectedPage(Internationalization());
                }),
            buildDrawerRowEntryWithoutIcon(
                title: 'Media Library',
                onTap: () {
                  setSelectedPage(MediaLibrarySettingsPage());
                }),
            buildDrawerRowEntryWithoutIcon(
                title: 'Webhooks',
                onTap: () {
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                  ));
                }),
            16.heightBox,
            Text(
              'ADMINISTRATION PANEL',
              style: _drawerTitleText,
            ).py(16),
            buildDrawerRowEntryWithoutIcon(
                title: 'Roles',
                onTap: () {
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                  ));
                }),
            buildDrawerRowEntryWithoutIcon(
                title: 'Users',
                onTap: () {
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                  ));
                }),
            16.heightBox,
            Text(
              'USERS & PERMISSONS PLUGIN',
              style: _drawerTitleText,
            ).py(16),
            buildDrawerRowEntryWithoutIcon(
                title: 'Roles',
                onTap: () {
                  setSelectedPage(RolesPage(
                    isAdmin: false,
                  ));
                }),
            buildDrawerRowEntryWithoutIcon(
                title: 'Providers',
                onTap: () {
                  setSelectedPage(ProvidersSettings());
                }),
            buildDrawerRowEntryWithoutIcon(
                title: 'Email Templates',
                onTap: () {
                  setSelectedPage(EmailTemplateSettingsPage());
                }),
            buildDrawerRowEntryWithoutIcon(
                title: 'Advanced Settings',
                onTap: () {
                  setSelectedPage(AdvancedSettingsScreen());
                }),
            16.heightBox,
            Text(
              'EMAIL PLUGIN',
              style: _drawerTitleText,
            ).py(16),
            buildDrawerRowEntryWithoutIcon(
                title: 'Email Settings',
                onTap: () {
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                  ));
                }),
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
