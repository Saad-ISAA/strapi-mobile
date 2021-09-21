import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Drawer buildContentDrawer() {
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Content'.text.xl3.bold.make(),
                Card(
                  elevation: 2,
                  child: Icon(Icons.search).p(5),
                ),
              ],
            ),
            16.heightBox,
            Text(
              'COLLECTION TYPES',
              style: _drawerTitleText,
            ).py(16),
            buildDrawerRowEntryWithoutIcon(title: 'Like', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Permission', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Restaurants', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Lablel ID', onTap: () {}),
            16.heightBox,
            Text(
              'SINGLE TYPES',
              style: _drawerTitleText,
            ).py(16),
            buildDrawerRowEntryWithoutIcon(title: 'Categories', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Label B', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Label C', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Label D', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Label E', onTap: () {}),
            buildDrawerRowEntryWithoutIcon(title: 'Label F', onTap: () {}),
            16.heightBox,
          ],
        ).p(16),
      ),
    ),
  );
}

TextStyle _drawerTitleText =
    TextStyle(color: neutral600, fontSize: 15, fontWeight: FontWeight.bold);

Widget buildDrawerRowEntryWithoutIcon({String title, Function onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(8),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Row(
        children: [
          Container(
              height: 9,
              width: 9,
              decoration:
                  BoxDecoration(color: neutral500, shape: BoxShape.circle)),
          SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15, color: drawerRowsColor),
          )
        ],
      ),
    ),
  );
}
