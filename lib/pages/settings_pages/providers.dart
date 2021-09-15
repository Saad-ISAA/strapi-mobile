import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class ProvidersSettings extends StatefulWidget {
  const ProvidersSettings({Key key}) : super(key: key);

  @override
  _ProvidersSettingsState createState() => _ProvidersSettingsState();
}

class _ProvidersSettingsState extends State<ProvidersSettings> {
  Future<Map<String, dynamic>> _fetchProviders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String adminURL = prefs.getString('adminURL');
    String token = prefs.getString('token');
    print(adminURL);
    var url = Uri.parse('$adminURL/users-permissions/providers');
    try {
      var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  void initState() {
    super.initState();

    _fetchProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            child: FutureBuilder(
              future: _fetchProviders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none && !snapshot.hasData) {
                  //print('project snapshot data is: ${snapshot.data}');
                  return Container();
                } else if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  //print('project snapshot data is: ${snapshot.data}');
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<ProvidersRow> providerList = [];
                  snapshot.data.forEach((key, value) {
                    providerList.add(new ProvidersRow(
                      title: '${key[0].toUpperCase()}${key.substring(1)}',
                      isEnabled: value["enabled"],
                      icon: 'assets/icons/providers/discord.svg',
                    ));
                  });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      '1 provider is enabled and 14 are disabled'.text.xl2.semiBold.softWrap(true).make().px(16),
                      24.heightBox,
                      ...providerList
                      // ProvidersRow(
                      //   title: 'Auth0',
                      //   isEnabled: false,
                      // ),
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
                  ).pOnly(top: 16);
                }
              },
            ),
          ),
        ],
      ).p(24),
    ));
  }
}

class ProvidersRow extends StatelessWidget {
  const ProvidersRow({Key key, this.icon, this.title, this.isEnabled = true}) : super(key: key);

  final String icon;
  final String title;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showEditProviderDialog(context, title);
      },
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 8,
                child: Row(
                  children: [
                    if (icon != null)
                      SvgPicture.asset(
                        icon,
                        color: neutral800,
                        height: 15,
                      ),
                    16.widthBox,
                    title.text.lg.softWrap(true).make(),
                  ],
                ),
              ),
              (isEnabled) ? 'Enabled'.text.color(success500).make() : 'Disabled'.text.color(danger500).make(),
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

dynamic showEditProviderDialog(context, String title) {
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
                          val: false,
                        ).px(16),
                        Text(
                          'If disabled, users won\'t be able to use this provider.',
                          style: TextStyle(color: neutral400),
                        ).px(16),
                        16.heightBox,
                        PrimaryTextField(
                          controller: null,
                          title: 'Client ID',
                          hintText: 'TEXT',
                        ).px(16),
                        PrimaryTextField(
                          controller: null,
                          title: 'Client Secret',
                          hintText: 'TEXT',
                        ).p(16),
                        PrimaryTextField(
                          controller: TextEditingController(text: 'my.subdomain.com/cas'),
                          title: 'Host URI (Subdomain)',
                        ).px(16),
                        PrimaryTextField(
                          controller: TextEditingController(text: '/auth/cas/callback'),
                          title: 'The redirect URL to your front-end app',
                        ).p(16),
                        PrimaryTextField(
                          controller: null,
                          hintText: '/connect/cas/callback',
                          title: 'The redirect URL to add in your Cas application configurations',
                        ).px(16),
                        Container(
                          decoration: BoxDecoration(color: neutral100, borderRadius: BorderRadius.circular(3)),
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
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
