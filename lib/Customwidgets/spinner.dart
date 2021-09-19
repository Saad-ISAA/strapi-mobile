import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

class CustomSpinner extends StatelessWidget {
  final Color color;
  CustomSpinner({this.color = strapiColor});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: new AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
