import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/providerController.dart';
import 'package:strapi_flutter_cms/models/provider.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class ProvidersSettings extends StatefulWidget {
  const ProvidersSettings({Key key}) : super(key: key);

  @override
  _ProvidersSettingsState createState() => _ProvidersSettingsState();
}

class _ProvidersSettingsState extends State<ProvidersSettings> {
  List<Map<String, ProviderDetail>> providers = [];
  bool loading = true;
  int enabledProvidersCount = 0;
  int disabledProvidersCount = 0;

  void initState() {
    fetchProviders()
        .then((value) => {
              setState(() {
                providers = value;
                _setEnabledAndDisabledProviderCount();
              })
            })
        .whenComplete(() => setState(() {
              loading = false;
            }));

    super.initState();
  }

  void _setEnabledAndDisabledProviderCount() {
    int enabledCount = 0;
    int disabledCount = 0;
    providers.forEach((item) {
      var itemKey = item.keys.toList()[0];
      print(itemKey);
      if (item[itemKey].enabled == true)
        enabledCount += 1;
      else
        disabledCount += 1;
    });
    setState(() {
      enabledProvidersCount = enabledCount;
      disabledProvidersCount = disabledCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? CustomSpinner()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          '$enabledProvidersCount provider is enabled and $disabledProvidersCount are disabled'
                              .text
                              .xl2
                              .semiBold
                              .softWrap(true)
                              .make()
                              .px(16),
                          24.heightBox,
                          ...providers.map((provider) => ProvidersRow(
                                title: provider.keys.toList()[0],
                                icon: provider.values.toList()[0].icon,
                                isEnabled: provider.values.toList()[0].enabled,
                                providerDetail: provider.values.toList()[0],
                              )),
                          // ProvidersRow(
                          //   title: 'Cas',
                          //   isEnabled: false,
                          // ),
                          // ProvidersRow(
                          //   icon: 'assets/icons/email-template.svg',
                          //   title: 'Email',
                          //   isEnabled: true,
                          // ),
                          // ProvidersRow(
                          //   icon: 'assets/icons/github.svg',
                          //   title: 'Github',
                          //   isEnabled: false,
                          // ),
                          // ProvidersRow(
                          //   icon: 'assets/icons/twitter.svg',
                          //   title: 'Twitter',
                          //   isEnabled: false,
                          // ),
                        ],
                      ).pOnly(top: 16)),
                ),
              ],
            ).p(24),
    );
  }
}

class ProvidersRow extends StatelessWidget {
  const ProvidersRow(
      {Key key,
      this.icon,
      this.title,
      this.isEnabled = true,
      this.providerDetail})
      : super(key: key);

  final String icon;
  final String title;
  final bool isEnabled;
  final ProviderDetail providerDetail;

  IconData _loadIcon(String code) {
    switch (code) {
      case 'aws':
        return FontAwesomeIcons.aws;
      case 'envelope':
        return FontAwesomeIcons.envelope;
      case 'discord':
        return FontAwesomeIcons.discord;
      case 'facebook-square':
        return FontAwesomeIcons.facebookSquare;
      case 'google':
        return FontAwesomeIcons.google;
      case 'github':
        return FontAwesomeIcons.github;
      case 'windows':
        return FontAwesomeIcons.windows;
      case 'twitter':
        return FontAwesomeIcons.twitter;
      case 'instagram':
        return FontAwesomeIcons.instagram;
      case 'vk':
        return FontAwesomeIcons.vk;
      case 'twitch':
        return FontAwesomeIcons.twitch;
      case 'linkedin':
        return FontAwesomeIcons.linkedin;
      default:
        return FontAwesomeIcons.borderNone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showEditProviderDialog(context, title, providerDetail);
      },
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 8,
                child: Row(
                  children: [
                    if (icon != null) Icon(_loadIcon(icon), size: 15),
                    16.widthBox,
                    title.text.lg.softWrap(true).make(),
                  ],
                ),
              ),
              (isEnabled)
                  ? 'Enabled'.text.color(success500).make()
                  : 'Disabled'.text.color(danger500).make(),
              32.widthBox,
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  height: 10,
                ),
              )
            ],
          ).p(16),
          Divider(
            height: 12,
            color: neutral400,
            thickness: 0.1,
          ).px(16),
        ],
      ),
    );
  }
}

dynamic showEditProviderDialog(
    context, String title, ProviderDetail providerDetail) {
  var clientIDController = TextEditingController(text: '${providerDetail.key}');
  var clientSecretController =
      TextEditingController(text: '${providerDetail.secret}');
  var hostURLController = TextEditingController(text: "www.yoursubdomain.com");
  var redirectURLController =
      TextEditingController(text: providerDetail.redirectUri);
  var callbackURLController =
      TextEditingController(text: providerDetail.callback);

  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          children: [
            Container(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        55.heightBox,
                        Text(
                          'Enable',
                          style: TextStyle(fontSize: 16),
                        ).px(16),
                        StrapiSwitch(
                          val: providerDetail.enabled,
                        ).px(16),
                        Text(
                          'If disabled, users won\'t be able to use this provider.',
                          style: TextStyle(color: neutral400),
                        ).px(16),
                        16.heightBox,
                        PrimaryTextField(
                          controller: clientIDController,
                          title: 'Client ID',
                          hintText: 'TEXT',
                        ).px(16),
                        PrimaryTextField(
                          controller: clientSecretController,
                          title: 'Client Secret',
                          hintText: 'TEXT',
                        ).p(16),
                        PrimaryTextField(
                          controller: hostURLController,
                          title: 'Host URI (Subdomain)',
                        ).px(16),
                        PrimaryTextField(
                          controller: redirectURLController,
                          title: 'The redirect URL to your front-end app',
                        ).p(16),
                        PrimaryTextField(
                          controller: callbackURLController,
                          hintText: '/connect/cas/callback',
                          title:
                              'The redirect URL to add in your $title application configurations',
                        ).px(16),
                        Container(
                          decoration: BoxDecoration(
                              color: neutral100,
                              borderRadius: BorderRadius.circular(3)),
                          child: Row(
                            children: [
                              Expanded(child: PrimaryCancelGreySquareButton(
                                onPressed: () {
                                  context.pop();
                                },
                              )),
                              24.widthBox,
                              Expanded(
                                child: MaterialButton(
                                  elevation: 0,
                                  onPressed: () {},
                                  color: success500,
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ).p(16),
                        ),
                      ],
                    ).pOnly(top: 24),
                  ),
                  buildHeader(context, 'Edit Provider > $title'),
                ],
              ),
            ),
          ],
        );
      });
}
