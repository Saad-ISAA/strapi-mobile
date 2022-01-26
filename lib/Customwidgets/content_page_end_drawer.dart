import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/models/content_type.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Drawer buildContentDrawer(context,
    {List<ContentType> singleTypes,
    List<ContentType> collectionTypes,
    Function(ContentType) setContentType}) {
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
                  child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Icon(Icons.search).p(4)),
                ),
              ],
            ),
            16.heightBox,
            InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'COLLECTION TYPES',
                      style: _drawerTitleText,
                    ),
                  ],
                ),
              ),
            ).py(8),
            ...collectionTypes
                .map(((type) => buildDrawerRowEntryWithoutIcon(
                    title: '${type.info.displayName}',
                    onTap: () {
                      setContentType(type);
                      Navigator.pop(context);
                    })))
                .toList(),
            16.heightBox,
            InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'SINGLE TYPES',
                      style: _drawerTitleText,
                    ),
                  ],
                ),
              ),
            ).py(8),
            ...singleTypes
                .map(((type) => buildDrawerRowEntryWithoutIcon(
                    title: '${type.info.displayName}',
                    onTap: () {
                      setContentType(type);
                      Navigator.pop(context);
                    })))
                .toList(),
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
    splashColor: primary200,
    highlightColor: primary200,
    borderRadius: BorderRadius.circular(8),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      child: Row(
        children: [
          Container(
              height: 7,
              width: 7,
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
