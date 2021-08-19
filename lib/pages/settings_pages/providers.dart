import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ProvidersSettings extends StatelessWidget {
  const ProvidersSettings({Key key}) : super(key: key);

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
                  '1 provider is enabled and 14 are disabled'
                      .text
                      .xl2
                      .semiBold
                      .softWrap(true)
                      .make()
                      .px(16),
                  24.heightBox,
                  ProvidersRow(
                    title: 'Auth0',
                    isEnabled: false,
                  ),
                  ProvidersRow(
                    title: 'Cas',
                    isEnabled: false,
                  ),
                  ProvidersRow(
                    icon: 'assets/icons/email-template.svg',
                    title: 'Email',
                    isEnabled: true,
                  ),
                  ProvidersRow(
                    icon: 'assets/icons/github.svg',
                    title: 'Github',
                    isEnabled: false,
                  ),
                  ProvidersRow(
                    icon: 'assets/icons/twitter.svg',
                    title: 'Twitter',
                    isEnabled: false,
                  ),
                ],
              ).pOnly(top: 16)),
        ],
      ).p(24),
    );
  }
}

class ProvidersRow extends StatelessWidget {
  const ProvidersRow({Key key, this.icon, this.title, this.isEnabled = true})
      : super(key: key);

  final String icon;
  final String title;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
