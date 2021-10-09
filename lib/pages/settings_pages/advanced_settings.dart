import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/advancedSettingsController.dart';
import 'package:strapi_flutter_cms/models/advanced_settings.dart';
import 'package:strapi_flutter_cms/models/role.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  const AdvancedSettingsScreen({Key key}) : super(key: key);

  @override
  _AdvancedSettingsScreenState createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen> {
  bool loading = true;
  AdvancedSettings advancedSettings;
  Role defaultRole;
  bool _oneAccountPerEmail = false;
  bool _enableSignUp = false;
  bool _enableEmailConfirmation = false;
  var resetPasswordPageURLController = TextEditingController();
  var emailConfirmationRedirectURLController = TextEditingController();

  void initState() {
    fetchAdvancedSettings().then((value) {
      advancedSettings = value;
      _oneAccountPerEmail = value.settings.uniqueEmail;
      _enableSignUp = value.settings.allowRegister;
      _enableEmailConfirmation = value.settings.emailConfirmation;
      resetPasswordPageURLController.text = value.settings.emailResetPassword;
      emailConfirmationRedirectURLController.text =
          value.settings.emailConfirmationRedirection;
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
      child: loading
          ? CustomSpinner()
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 'Advanced Settings'.text.xl3.semiBold.softWrap(true).make(),
                  // 24.heightBox,
                  'Settings'.text.xl2.semiBold.make(),
                  24.heightBox,
                  _buildRoleDropdown(
                      roles: advancedSettings.roles,
                      selectedRole: advancedSettings?.roles[0]),
                  24.heightBox,
                  buildStrapiSwitchWIthTitle(
                      title: 'One account per email address',
                      value: _oneAccountPerEmail,
                      description:
                          'Disallow the user to create multiple accounts using the same email address with different authentication providers.'),
                  24.heightBox,
                  buildStrapiSwitchWIthTitle(
                      title: 'Enable sign-ups',
                      value: _enableSignUp,
                      description:
                          'When disabled (OFF), the registration process is forbidden. No one can subscribe anymore no matter the used provider.'),
                  24.heightBox,

                  PrimaryTextField(
                    controller: resetPasswordPageURLController,
                    title: 'Reset password page',
                    hintText: 'ex: https://yourfrontend.com/reset-psssword',
                    descriptionText:
                        'URL of your application\'s reset password page',
                  ),
                  24.heightBox,
                  buildStrapiSwitchWIthTitle(
                      title: 'Enable email confirmation',
                      value: _enableEmailConfirmation,
                      description:
                          'When enabled (ON), new registered users receive a confirmation email.'),
                  24.heightBox,
                  PrimaryTextField(
                    controller: emailConfirmationRedirectURLController,
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
            ),
    );
  }

  Column _buildRoleDropdown(
      {List<Role> roles, Role selectedRole, Function(Role) onRoleChange}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        'Default role for authenticated users'.text.lg.softWrap(true).make(),
        12.heightBox,
        StrapiDropdown(
            onChanged: (v) {
              onRoleChange(v);
            },
            value: selectedRole?.id,
            items: roles
                .map((role) => DropdownMenuItem(
                      child: '${role.name}'.text.make(),
                      value: role.id,
                      onTap: () {},
                    ))
                .toList()),
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
