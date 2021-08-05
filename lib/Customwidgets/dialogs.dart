import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

dynamic showMediaLibraryInfoDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          children: [
            Container(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        55.heightBox,
                        _buildImageSection().p(4),
                        _buildInfoSection().p(12),
                        PrimaryTextField(
                          controller: null,
                          title: 'File Name',
                        ).px(16),
                        PrimaryTextField(
                          controller: null,
                          title: 'Alternative Text',
                          descriptionText:
                              'This text will be displayed if the assets can\'t be shown.',
                        ).p(16).py(8),
                        PrimaryTextField(
                          controller: null,
                          title: 'Caption',
                        ).px(16),
                        24.heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                elevation: 0,
                                onPressed: () {},
                                color: blue,
                                child: Text(
                                  'Replace Media',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            24.widthBox,
                            Expanded(
                              child: MaterialButton(
                                elevation: 0,
                                onPressed: () {},
                                color: success500,
                                child: Text(
                                  'Finish',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ).px(16),
                      ],
                    ).py(24),
                  ),
                  _buildHeader(context),
                ],
              ),
            ),
          ],
        );
      });
}

Stack _buildImageSection() {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Colors.grey[800],
            child: Image.asset('assets/images/placeholder.png'),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StrapiIconButton(onPressed: () {}, icon: 'assets/icons/delete.svg')
              .px(8),
          StrapiIconButton(onPressed: () {}, icon: 'assets/icons/download.svg'),
          StrapiIconButton(onPressed: () {}, icon: 'assets/icons/link.svg')
              .px(8),
          StrapiIconButton(onPressed: () {}, icon: 'assets/icons/crop.svg'),
        ],
      ).p(8),
    ],
  );
}

Container _buildInfoSection() {
  return Container(
    decoration: BoxDecoration(
        color: neutral100, borderRadius: BorderRadius.circular(3)),
    child: Column(
      children: [
        Row(
          children: [
            _mediaLibraryItemInfoEntry(key: 'Size', val: '4MB'),
            _mediaLibraryItemInfoEntry(
                key: 'Date', val: 'Monday, August 2nd 2021'),
          ],
        ),
        16.heightBox,
        Row(
          children: [
            _mediaLibraryItemInfoEntry(key: 'Dimensions', val: '2880x1800'),
            _mediaLibraryItemInfoEntry(key: 'Extension', val: 'PNG'),
          ],
        ),
      ],
    ).p(16),
  );
}

Container _buildHeader(BuildContext context) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
        color: neutral100,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Details',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))
            .pOnly(left: 12),
        IconButton(
            splashRadius: 20,
            padding: EdgeInsets.all(0),
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.close, size: 20, color: neutral500)),
      ],
    ),
  );
}

Widget _mediaLibraryItemInfoEntry({String key, String val}) {
  return Expanded(
    flex: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14, color: neutral500, fontWeight: FontWeight.bold),
        ).py(6),
        Text(
          val,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: neutral500),
        ),
      ],
    ),
  );
}
