import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/localeController.dart';
import 'package:strapi_flutter_cms/models/locale.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class Internationalization extends StatefulWidget {
  const Internationalization({Key key}) : super(key: key);

  @override
  _InternationalizationState createState() => _InternationalizationState();
}

class _InternationalizationState extends State<Internationalization> {
  List<SelectedLocale> userLocales = [];
  bool loading = true;
  void initState() {
    fetchUserSelectedLocales()
        .then((value) {
          setState(() {
            userLocales = value;
          });
        })
        .catchError((err) {})
        .whenComplete(() {
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '${userLocales.length} Locale'
                            .text
                            .xl2
                            .semiBold
                            .make()
                            .px(16),
                        24.heightBox,
                        ...userLocales
                            .map((locale) => LocaleRow(
                                  code: '${locale.code}',
                                  name: '${locale.name}',
                                  isDefault: locale.isDefault,
                                  locale: locale,
                                ))
                            .toList()
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
  const LocaleRow({Key key, this.code, this.name, this.isDefault, this.locale})
      : super(key: key);

  final String code;
  final String name;
  final bool isDefault;
  final SelectedLocale locale;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        onTap: () {
          showAddLocaleDialog(context, locale);
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
      ),
    );
  }
}
