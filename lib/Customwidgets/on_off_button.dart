import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class StrapiSwitch extends StatelessWidget {
  const StrapiSwitch({
    Key key,
    this.onOffPress,
    this.onOnPress,
    this.val = true,
  }) : super(key: key);
  final bool val;
  final Function() onOffPress;
  final Function() onOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: onOffPress,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: (val == false) ? 0.1 : 0.0,
                        blurRadius: (val == false) ? 2 : 0.0,
                        color: Colors.black38)
                  ],
                  color: (val == false) ? danger500 : Colors.white,
                  border: (val == false)
                      ? null
                      : Border(
                          left: BorderSide(color: neutral400, width: 0.5),
                          top: BorderSide(color: neutral400, width: 0.5),
                          bottom: BorderSide(color: neutral400, width: 0.5),
                        )),
              height: 33,
              width: 60,
              child: Center(
                child: Text(
                  'OFF',
                  style: TextStyle(
                      color: (val == false) ? Colors.white : neutral400,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onOnPress,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  color: (val == true) ? blue : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: (val == true) ? 0.1 : 0.0,
                        blurRadius: (val == true) ? 2 : 0.0,
                        color: Colors.black38)
                  ],
                  border: (val == true)
                      ? null
                      : Border(
                          right: BorderSide(color: neutral400, width: 0.5),
                          top: BorderSide(color: neutral400, width: 0.5),
                          bottom: BorderSide(color: neutral400, width: 0.5),
                        )),
              height: 33,
              width: 60,
              child: Center(
                child: Text(
                  'ON',
                  style: TextStyle(
                      color: (val == true) ? Colors.white : neutral400,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ).py(12),
    );
  }
}
