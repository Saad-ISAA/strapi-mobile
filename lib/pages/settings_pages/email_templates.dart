import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class EmailTemplateSettingsPage extends StatelessWidget {
  const EmailTemplateSettingsPage({Key key}) : super(key: key);

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
                  '2 email templates are available'
                      .text
                      .xl2
                      .semiBold
                      .softWrap(true)
                      .make()
                      .px(16),
                  24.heightBox,
                  EmailTemplateRow(
                    icon: 'assets/icons/reload.svg',
                    title: 'Reset Password',
                  ),
                  EmailTemplateRow(
                    icon: 'assets/icons/check-icon.svg',
                    title: 'Email address confirmation',
                  ),
                ],
              ).pOnly(top: 16)),
        ],
      ).p(24),
    );
  }
}

class EmailTemplateRow extends StatelessWidget {
  const EmailTemplateRow({Key key, this.icon, this.title}) : super(key: key);

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 15,
              ),
              16.widthBox,
              title.text.lg.softWrap(true).make(),
            ],
          ),
          Spacer(),
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
