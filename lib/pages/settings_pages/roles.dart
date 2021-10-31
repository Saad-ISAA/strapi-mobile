import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/roleController.dart';
import 'package:strapi_flutter_cms/models/role.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key, this.isAdmin = false}) : super(key: key);
  final bool isAdmin;
  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  bool loading = true;
  var roles = [];
  void initState() {
    if (widget.isAdmin) {
      fetchAdminRoles().then((value) {
        setState(() {
          print(value);
          roles = value;
        });
      }).whenComplete(() {
        setState(() {
          loading = false;
        });
      });
    }
    fetchRoles().then((value) {
      setState(() {
        print(value);
        roles = value;
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
        children: loading
            ? [CustomSpinner()]
            : [
                Expanded(
                  child: Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          '${roles.length} roles'
                              .text
                              .xl3
                              .semiBold
                              .overflow(TextOverflow.clip)
                              .make()
                              .px(16),
                          24.heightBox,
                          Expanded(
                              child: ListView(
                            children: [
                              ...roles.map((role) {
                                return Column(
                                  children: [
                                    RoleRow(
                                        status: '${role.name}',
                                        name: '${role.description}',
                                        user:
                                            '${widget.isAdmin ? role.usersCount : role.nbUsers} user'),
                                    Divider(height: 4),
                                    16.heightBox,
                                  ],
                                );
                              }).toList(),
                            ],
                          ))
                          // RoleRow(
                          //   status: 'Authenticated',
                          //   name: 'Default role given to authenticated user',
                          //   user: '0 user',
                          // ),
                          // Divider(height: 4),
                          // 16.heightBox,
                          // RoleRow(
                          //   status: 'Public',
                          //   name: 'Default role given to authenticated user',
                          //   user: '0 user',
                          // ),
                          // Divider(height: 4)
                        ],
                      ).pOnly(top: 16)),
                ),
                8.heightBox,
                PrimarySquareButton(
                  onPressed: () {},
                  color: primary600,
                  text: '+ Add new role',
                )
              ],
      ).p(24),
    );
  }
}

class RoleRow extends StatelessWidget {
  const RoleRow({Key key, this.status, this.name, this.user}) : super(key: key);

  final String status;
  final String name;
  final String user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: status.text.lg.make()),
              user.text.lg.make(),
            ],
          ),
          16.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              name.text.medium.make(),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  height: 10,
                ),
              )
            ],
          ),
        ],
      ).p(16),
    );
  }
}
