import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class Internationalization extends StatelessWidget {
  const Internationalization({Key key}) : super(key: key);

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
                  '1 Locale'.text.xl2.semiBold.make().px(16),
                  24.heightBox,
                  LocaleRow(
                    code: 'en',
                    name: 'English(en)',
                    isDefault: true,
                  ),
                ],
              ).pOnly(top: 16)),
          Spacer(),
          PrimarySquareButton(
            color: blue,
            text: '+ Add Locale',
          )
        ],
      ).p(24),
    );
  }
}

class LocaleRow extends StatelessWidget {
  const LocaleRow({Key key, this.code, this.name, this.isDefault})
      : super(key: key);

  final String code;
  final String name;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAddLocaleDialog(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          code.text.lg.make(),
          name.text.lg.make(),
          (isDefault) ? 'Default Locale'.text.lg.make() : SizedBox.shrink(),
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
