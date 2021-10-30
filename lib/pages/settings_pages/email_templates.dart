import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/emailTemplateController.dart';
import 'package:strapi_flutter_cms/models/email_template.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Map<String, String> templateIcons = {
  "sync": "assets/icons/reload.svg",
  "check-square": "assets/icons/check-icon.svg"
};

class EmailTemplateSettingsPage extends StatefulWidget {
  const EmailTemplateSettingsPage({Key key}) : super(key: key);

  @override
  _EmailTemplateSettingsPageState createState() =>
      _EmailTemplateSettingsPageState();
}

class _EmailTemplateSettingsPageState extends State<EmailTemplateSettingsPage> {
  bool loading = true;
  List<EmailTemplate> emailTemplates = [];

  void initState() {
    fetchEmailTemplateSettings().then((value) {
      setState(() {
        emailTemplates = value;
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

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
                  '${emailTemplates.length} email templates are available'
                      .text
                      .xl2
                      .semiBold
                      .softWrap(true)
                      .make()
                      .px(16),
                  24.heightBox,
                  ...emailTemplates
                      .map((template) => EmailTemplateRow(
                            template: template,
                          ))
                      .toList(),
                ],
              ).pOnly(top: 16)),
        ],
      ).p(24),
    );
  }
}

class EmailTemplateRow extends StatelessWidget {
  const EmailTemplateRow({Key key, this.template}) : super(key: key);

  final EmailTemplate template;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showEditTemplateDialog(context, template);
      },
      child: Row(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                templateIcons[template.icon],
                height: 15,
              ),
              16.widthBox,
              template.display
                  .split(".")[2]
                  ?.replaceAll(RegExp(r'_'), " ")
                  ?.firstLetterUpperCase()
                  ?.text
                  ?.lg
                  ?.softWrap(true)
                  ?.make(),
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

dynamic showEditTemplateDialog(context, EmailTemplate template) {
  var shipperNameController =
      TextEditingController(text: template.options.from.name);
  var shipperEmailController =
      TextEditingController(text: template.options.from.email);
  var responseEmailController =
      TextEditingController(text: template.options.responseEmail);
  var objectController = TextEditingController(text: template.options.object);
  var messageController = TextEditingController(text: template.options.message);

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
                          controller: shipperNameController,
                          title: 'Shipper name',
                        ).px(16),
                        PrimaryTextField(
                          controller: shipperEmailController,
                          title: 'Shipper Email',
                        ).p(16),
                        PrimaryTextField(
                          controller: responseEmailController,
                          title: 'Response Email',
                          hintText: 'kai@doe.com',
                        ).px(16),
                        PrimaryTextField(
                          controller: objectController,
                          title: 'Subject',
                          descriptionText:
                              'If you\'re unsure how to use variables, check out our documentation.',
                        ).p(16),
                        PrimaryTextField(
                          controller: messageController,
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
