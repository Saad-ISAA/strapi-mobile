import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryTextField extends StatelessWidget {
  PrimaryTextField(
      {Key key,
      @required this.controller,
      this.title,
      this.descriptionText,
      this.hintText = '',
      this.inputType = TextInputType.text,
      this.isObscure = false,
      this.icon})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String descriptionText;
  final String hintText;
  final String icon;
  final bool isObscure;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (title != null)
            ? Text(
                title,
                style: labelStyle,
                softWrap: true,
              ).pOnly(bottom: 10)
            : SizedBox.shrink(),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: neutral500,
              ),
              borderRadius: BorderRadius.circular(4)),
          height: 45.0,
          child: TextField(
            obscureText: isObscure,
            keyboardType: inputType,
            style: TextStyle(
              color: neutral900,
              fontFamily: 'OpenSans',
            ),
            controller: controller,
            decoration: (icon != null)
                ? InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primary700)),
                    contentPadding: EdgeInsets.only(top: 10, bottom: 8),
                    prefixIcon: SvgPicture.asset(icon).px(12),
                    hintText: hintText,
                    hintStyle: hintTextStyle,
                  )
                : InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 16, right: 16, bottom: 6),
                    hintText: hintText,
                    hintStyle: hintTextStyle,
                  ),
          ),
        ),
        (descriptionText != null)
            ? Text(descriptionText, style: TextStyle(color: neutral500))
                .pOnly(top: 5)
            : SizedBox.shrink(),
      ],
    );
  }

  final hintTextStyle = TextStyle(
    color: neutral500,
    fontSize: 15,
    fontFamily: 'OpenSans',
  );
}

final labelStyle = TextStyle(
  color: neutral800,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  fontFamily: 'OpenSans',
);
