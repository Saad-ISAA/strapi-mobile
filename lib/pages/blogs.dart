import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkNavyBlue,
      child: Center(
        child: Text(
          'Main Entry Page',
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}
