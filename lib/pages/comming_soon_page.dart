import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class CommingSoonPage extends StatelessWidget {
  final String message;
  const CommingSoonPage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // row for expanding column horizontally
                Row(),
                SvgPicture.asset(
                  'assets/icons/emptypage.svg',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                ),
                24.heightBox,
                message.text.xl.semiBold.center.make(),
              ],
            )));
  }
}
