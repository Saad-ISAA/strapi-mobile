import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

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

class PrimarySquareButton extends StatelessWidget {
  const PrimarySquareButton({Key key, this.text, this.color, this.onPressed})
      : super(key: key);

  final String text;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: neutral300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      minWidth: double.infinity,
      height: 40,
      elevation: 0,
      onPressed: onPressed,
      color: color,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class PrimarySettingsButton extends StatelessWidget {
  const PrimarySettingsButton(
      {Key key, this.text, this.color, this.onPressed, this.icon})
      : super(key: key);

  final String text;
  final Color color;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: neutral300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minWidth: double.infinity,
      height: 45,
      elevation: 0,
      onPressed: onPressed,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (icon == null)
              ? SizedBox()
              : Icon(
                  icon,
                  color: Colors.white,
                ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class PrimaryCancelGreySquareButton extends StatelessWidget {
  const PrimaryCancelGreySquareButton({Key key, this.onPressed, this.text})
      : super(key: key);

  final Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: BorderSide(color: neutral500, width: 1)),
      minWidth: double.infinity,
      height: 37,
      elevation: 0,
      onPressed: onPressed,
      color: Colors.white,
      child: Text(
        (text != null) ? text : 'Cancel',
        style: TextStyle(fontWeight: FontWeight.bold, color: neutral500),
      ),
    );
  }
}
