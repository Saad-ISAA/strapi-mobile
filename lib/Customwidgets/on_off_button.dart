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
              duration: Duration(milliseconds: 350),
              decoration: BoxDecoration(
                  color: (val == false)
                      ? danger600.withOpacity(0.2)
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                  border: Border.all(color: neutral400, width: 0.3)),
              height: 40,
              width: 70,
              child: Center(
                child: Text(
                  'OFF',
                  style: TextStyle(
                    color: (val == false) ? danger500 : neutral800,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onOnPress,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 350),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color:
                    (val == true) ? primary500.withOpacity(0.2) : Colors.white,
                border: Border.all(color: neutral400, width: 0.3),
              ),
              height: 40,
              width: 70,
              child: Center(
                child: Text(
                  'ON',
                  style: TextStyle(
                    color: (val == true) ? primary600 : neutral800,
                  ),
                ),
              ),
            ),
          )
        ],
      ).py(12),
    );
  }
}
