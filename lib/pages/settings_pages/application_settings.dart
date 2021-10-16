import 'package:flutter/material.dart';
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
  void initState() {
    fetchApplicationSettings().then((value) => {
          setState(() {
            admininfo = value;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Application'.text.xl2.semiBold.make(),
          5.heightBox,
          'See your project details'.text.medium.color(neutral500).make(),
          20.heightBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsDetailRow(
                  title: "STRAPI VERSION",
                  value: "v${admininfo?.strapiVersion}"),
              20.heightBox,
              SettingsDetailRow(
                  title: "CURRENT PLAN",
                  value:
                      "${admininfo != null ? admininfo.communityEdition ? 'Community' : '' : ""}"),
              20.heightBox,
              SettingsDetailRow(
                  title: "NODE VERSION", value: "${admininfo?.nodeVersion}"),
            ],
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
          title.text.medium.color(neutral500).make(),
          value.text.normal.color(neutral500).make(),
        ],
      ),
    );
  }
}
