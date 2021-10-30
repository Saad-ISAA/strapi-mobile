import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

class StrapiCheckBox extends StatelessWidget {
  StrapiCheckBox({
    Key key,
    @required this.onChanged,
    @required this.value,
  }) : super(key: key);

  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: neutral500,
      ),
      child: Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: value,
          checkColor: Colors.white,
          activeColor: primary600,
          onChanged: onChanged),
    );
  }
}
