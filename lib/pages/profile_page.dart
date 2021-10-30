import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../GlobalConfig.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // void initState() {
  //   getAdminInfo().then((value) {
  //     print(value);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral100,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${GlobalConfig.data.user['firstname']} ${GlobalConfig.data.user['lastname']}"
                .text
                .xl2
                .semiBold
                .make(),
            24.heightBox,
            ProfileCard(),
            24.heightBox,
            PasswordCard(),
            24.heightBox,
            ExperienceCard(),
          ],
        ).p(16),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  TextEditingController _fNameController;

  TextEditingController _lNameController;

  TextEditingController _emailController;

  TextEditingController _usernameController;

  @override
  void initState() {
    _fNameController =
        TextEditingController(text: GlobalConfig.data.user['firstname']);
    _lNameController =
        TextEditingController(text: GlobalConfig.data.user['lastname']);
    _emailController =
        TextEditingController(text: GlobalConfig.data.user['email']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Profile'.text.xl.make(),
          24.heightBox,
          PrimaryTextField(
            controller: _fNameController,
            title: 'First name',
          ),
          16.heightBox,
          PrimaryTextField(
            controller: _lNameController,
            title: 'Last name',
          ),
          16.heightBox,
          PrimaryTextField(
            controller: _emailController,
            title: 'Email',
          ),
          16.heightBox,
          PrimaryTextField(
            controller: _usernameController,
            title: 'Username',
          ),
        ],
      ).p(16),
    );
  }
}

class PasswordCard extends StatelessWidget {
  const PasswordCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Change Password'.text.xl.make(),
          24.heightBox,
          PrimaryTextField(
            controller: null,
            title: 'Password',
          ),
          16.heightBox,
          PrimaryTextField(
            controller: null,
            title: 'Confirmation password',
          ),
        ],
      ).p(16),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Experience'.text.xl.make(),
          24.heightBox,
          'Interface language'.text.size(15).make(),
          8.heightBox,
          StrapiDropdown(),
        ],
      ).p(16),
    );
  }
}
