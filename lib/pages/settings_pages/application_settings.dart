import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/applicationSettingsController.dart';
import 'package:strapi_flutter_cms/models/admin_information_model.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ApplicationSettingsPage extends StatefulWidget {
  const ApplicationSettingsPage({Key key}) : super(key: key);

  @override
  _ApplicationSettingsPageState createState() =>
      _ApplicationSettingsPageState();
}

class _ApplicationSettingsPageState extends State<ApplicationSettingsPage> {
  AdminInformation admininfo;
  bool loading = true;
  void initState() {
    fetchApplicationSettings()
        .then((value) => {
              setState(() {
                admininfo = value;
              })
            })
        .whenComplete(() => setState(() {
              loading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: neutral100,
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: loading
          ? CustomSpinner()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Application'.text.xl2.semiBold.make(),
                5.heightBox,
                'See your project details'.text.medium.color(neutral700).make(),
                20.heightBox,
                Card(
                  margin: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Information'.text.xl.make(),
                      24.heightBox,
                      SettingsDetailRow(
                          title: "DETAILS",
                          value: "v${admininfo?.strapiVersion}"),
                      20.heightBox,
                      Row(
                        children: [
                          SettingsDetailRow(
                              title: "CURRENT PLAN",
                              value:
                                  "${admininfo != null ? admininfo.communityEdition ? 'Community' : '' : ""}"),
                          Spacer(),
                          'SEE ALL PRICING'
                              .text
                              .color(primary600)
                              .size(12)
                              .semiBold
                              .make(),
                          8.widthBox,
                          Icon(
                            Icons.screen_share_outlined,
                            color: primary600,
                          )
                        ],
                      ),
                      20.heightBox,
                      SettingsDetailRow(
                          title: "NODE VERSION",
                          value: "${admininfo?.nodeVersion}"),
                    ],
                  ).p(16),
                )
              ],
            ),
    );
  }
}

class SettingsDetailRow extends StatelessWidget {
  final String title;
  final String value;
  const SettingsDetailRow({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title.text.size(12).semiBold.make(),
          value.text.normal.make(),
        ],
      ),
    );
  }
}
