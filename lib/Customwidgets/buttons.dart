import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class StrapiIconButton extends StatelessWidget {
  const StrapiIconButton(
      {Key key, @required this.onPressed, @required this.icon})
      : super(key: key);

  final Function onPressed;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        onPressed: onPressed,
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        child: SvgPicture.asset(icon, height: 17, color: neutral400),
      ),
    );
  }
}
