import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  const AdvancedSettingsScreen({Key key}) : super(key: key);

  @override
  _AdvancedSettingsScreenState createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 'Advanced Settings'.text.xl3.semiBold.softWrap(true).make(),
          // 24.heightBox,
          'Settings'.text.xl2.semiBold.make(),
          24.heightBox,
          _buildRoleDropdown(),
          24.heightBox,
          buildStrapiSwitchWIthTitle(
              title: 'One account per email address',
              value: true,
              description:
                  'Disallow the user to create multiple accounts using the same email address with different authentication providers.'),
          24.heightBox,
          buildStrapiSwitchWIthTitle(
              title: 'Enable sign-ups',
              value: true,
              description:
                  'When disabled (OFF), the registration process is forbidden. No one can subscribe anymore no matter the used provider.'),
          24.heightBox,

          PrimaryTextField(
            controller: null,
            title: 'Reset password page',
            hintText: 'ex: https://yourfrontend.com/reset-psssword',
            descriptionText: 'URL of your application\'s reset password page',
          ),
          24.heightBox,
          buildStrapiSwitchWIthTitle(
              title: 'Enable email confirmation',
              value: false,
              description:
                  'When enabled (ON), new registered users receive a confirmation email.'),
          24.heightBox,
          PrimaryTextField(
            controller: null,
            title: 'Redirection url',
            hintText: 'ex: https://yourfrontend.com/reset-psssword',
            descriptionText:
                'After you confirmed your email, choose where you will be redirected.',
          ),
          32.heightBox,
          PrimarySquareButton(
            color: success500,
            text: 'Save',
            onPressed: () {},
          ),
          8.heightBox,
          PrimaryCancelGreySquareButton(
            onPressed: () {},
            text: 'Reset',
          ),
          24.heightBox
        ],
      ).p(24),
    );
  }

  Column _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Default role for authenticated users'.text.lg.softWrap(true).make(),
        12.heightBox,
        StrapiDropdown(
          onChanged: (v) {},
          value: 1,
          items: [
            DropdownMenuItem(
              child: 'Authentication'.text.make(),
              value: 1,
              onTap: () {},
            )
          ],
        ),
        12.heightBox,
        'It will attach new authenticated user to new role'
            .text
            .softWrap(true)
            .color(neutral500)
            .make(),
      ],
    );
  }
}

Column buildStrapiSwitchWIthTitle(
    {String title,
    bool value,
    String description,
    Function onOnClick,
    Function onOffClick}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.lg.softWrap(true).make(),
      StrapiSwitch(
        onOnPress: onOnClick,
        onOffPress: onOffClick,
        val: value,
      ),
      description.text.softWrap(true).color(neutral500).make(),
    ],
  );
}
