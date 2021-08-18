import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({Key key}) : super(key: key);

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
                  '2 roles'.text.xl3.semiBold.make().px(16),
                  24.heightBox,
                  RoleRow(
                    status: 'Authenticated',
                    name: 'Default role given to authenticated user',
                    user: '0 user',
                  ),
                  Divider(height: 4),
                  16.heightBox,
                  RoleRow(
                    status: 'Public',
                    name: 'Default role given to authenticated user',
                    user: '0 user',
                  ),
                  Divider(height: 4)
                ],
              ).pOnly(top: 16)),
          Spacer(),
          PrimarySquareButton(
            color: blue,
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
