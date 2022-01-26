import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/pages/comming_soon_page.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/adminRoles.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/advanced_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/api_tokens.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/application_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/email_templates.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/internationalization.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/media_library_settings.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/providers.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/roles.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/messages.dart';
import 'package:strapi_flutter_cms/shared/settings_drawer_items.dart';
import 'package:velocity_x/velocity_x.dart';

Drawer buildSettingsDrawer(
    Function(Widget) setSelectedPage,
    SettingsDrawerItem activatedTab,
    Function(SettingsDrawerItem) setActivatedTab) {
  return Drawer(
    backgroundColor: neutral150,
    child: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Settings'.text.xl3.bold.make().py(10).px(16),
            16.heightBox,
            Text(
              'GLOBAL SETTINGS',
              style: _drawerTitleText,
            ).py(8).px(16),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                itemKey: SettingsDrawerItem.APPLICATION,
                title: 'Application',
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.APPLICATION);
                  setSelectedPage(ApplicationSettingsPage());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                itemKey: SettingsDrawerItem.APITOKENS,
                title: 'API Tokens',
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.APITOKENS);
                  setSelectedPage(APITokensScreen());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Internationalization',
                itemKey: SettingsDrawerItem.INTERNATIONLIZATION,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.INTERNATIONLIZATION);
                  setSelectedPage(Internationalization());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Media Library',
                itemKey: SettingsDrawerItem.MEDIALIBRARY,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.MEDIALIBRARY);
                  setSelectedPage(MediaLibrarySettingsPage());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Webhooks',
                itemKey: SettingsDrawerItem.WEBHOOKS,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.WEBHOOKS);
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                    showAppBar: false,
                  ));
                }),
            16.heightBox,
            Text(
              'ADMINISTRATION PANEL',
              style: _drawerTitleText,
            ).py(8).px(16),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                itemKey: SettingsDrawerItem.ADMIN_ROLES,
                title: 'Roles',
                onTap: () {
                  // setActivatedTab(SettingsDrawerItem.ADMIN_ROLES);
                  // setSelectedPage(CommingSoonPage(
                  //   message: contentInDevelopmentMessage,
                  //   showAppBar: false,
                  // ));

                  setActivatedTab(SettingsDrawerItem.ADMIN_ROLES);
                  setSelectedPage(AdminRolesPage());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Users',
                itemKey: SettingsDrawerItem.USERS,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.USERS);
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                    showAppBar: false,
                  ));
                }),
            16.heightBox,
            Text(
              'USERS & PERMISSONS PLUGIN',
              style: _drawerTitleText,
            ).py(8).px(16),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Roles',
                itemKey: SettingsDrawerItem.ROLES,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.ROLES);
                  setSelectedPage(RolesPage(
                    isAdmin: false,
                  ));
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Providers',
                itemKey: SettingsDrawerItem.PROVIDERS,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.PROVIDERS);
                  setSelectedPage(ProvidersSettings());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                itemKey: SettingsDrawerItem.EMAILTEMPLATES,
                title: 'Email Templates',
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.EMAILTEMPLATES);
                  setSelectedPage(EmailTemplateSettingsPage());
                }),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                itemKey: SettingsDrawerItem.ADVANCEDSETTINGS,
                title: 'Advanced Settings',
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.ADVANCEDSETTINGS);
                  setSelectedPage(AdvancedSettingsScreen());
                }),
            16.heightBox,
            Text(
              'EMAIL PLUGIN',
              style: _drawerTitleText,
            ).py(8).px(16),
            buildDrawerRowEntryWithoutIcon(
                activeItem: activatedTab,
                title: 'Email Settings',
                itemKey: SettingsDrawerItem.EMAILSETTINGS,
                onTap: () {
                  setActivatedTab(SettingsDrawerItem.EMAILSETTINGS);
                  setSelectedPage(CommingSoonPage(
                    message: contentInDevelopmentMessage,
                    showAppBar: false,
                  ));
                }),
          ],
        ),
      ),
    ),
  );
}

TextStyle _drawerTitleText =
    TextStyle(color: neutral600, fontSize: 14, fontWeight: FontWeight.bold);

Widget buildDrawerRowEntryWithoutIcon(
    {String title,
    Function onTap,
    SettingsDrawerItem activeItem,
    SettingsDrawerItem itemKey}) {
  return InkWell(
    splashColor: primary200,
    borderRadius: BorderRadius.circular(0),
    onTap: onTap,
    child: Container(
      color: activeItem == itemKey
          ? primary200.withOpacity(0.5)
          : Colors.transparent,
      child: Row(
        children: [
          32.widthBox,
          Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: activeItem == itemKey ? primary700 : drawerRowsColor,
                  shape: BoxShape.circle)),
          SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                color: activeItem == itemKey ? primary700 : drawerRowsColor,
                fontWeight: activeItem == itemKey
                    ? FontWeight.w600
                    : FontWeight.normal),
          ),
          Spacer(),
          Container(
            height: 40,
            width: 4,
            color: activeItem == itemKey ? primary700 : Colors.transparent,
          ),
        ],
      ),
    ),
  );
}
