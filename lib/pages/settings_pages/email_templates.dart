import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/checkbox.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
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
      onTap: () {
        showEditTemplateDialog(context);
      },
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

dynamic showEditTemplateDialog(context) {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        55.heightBox,
                        PrimaryTextField(
                          controller: TextEditingController(
                              text: 'Administration Panel'),
                          title: 'Shipper name',
                        ).px(16),
                        PrimaryTextField(
                          controller:
                              TextEditingController(text: 'no-reply@strapi.io'),
                          title: 'Shipper Email',
                        ).p(16),
                        PrimaryTextField(
                          controller: null,
                          title: 'Response Email',
                          hintText: 'kai@doe.com',
                        ).px(16),
                        PrimaryTextField(
                          controller: TextEditingController(
                              text: 'Account Information'),
                          title: 'Subject',
                          descriptionText:
                              'If you\'re unsure how to use variables, check out our documentation.',
                        ).p(16),
                        PrimaryTextField(
                          controller: null,
                          title: 'Message',
                        ).p(16),
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
                  buildHeader(context, 'Email address confirmation'),
                ],
              ),
            ),
          ],
        );
      });
}
