import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class StrapiDropdown extends StatefulWidget {
  StrapiDropdown({this.items, this.value, Key key, this.onChanged})
      : super(key: key);

  final List<DropdownMenuItem> items;
  Function(dynamic) onChanged;
  final int value;

  @override
  _StrapiDropdownState createState() => _StrapiDropdownState();
}

class _StrapiDropdownState extends State<StrapiDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: neutral300, width: 0.5)),
      child: DropdownButton(
        onChanged: widget.onChanged,
        value: widget.value,
        icon: Container(
          height: 38,
          width: 30,
          color: neutral150,
          child: Icon(Icons.keyboard_arrow_down),
        ),
        isExpanded: true,
        style: TextStyle(fontSize: 15, color: Colors.black),
        underline: SizedBox(),
        items: widget.items,
      ).pOnly(left: 12),
    );
  }
}
