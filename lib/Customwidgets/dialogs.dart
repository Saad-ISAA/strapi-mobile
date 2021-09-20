import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/Customwidgets/ComingSoonSnackbar.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/checkbox.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/controllers/mediaLibraryController.dart';
import 'package:strapi_flutter_cms/models/locale.dart';
import 'package:strapi_flutter_cms/models/media_library.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

dynamic showMediaLibraryInfoDialog(context, Media item) {
  var filenameController = TextEditingController(text: item.name);
  var alternativeTextController =
      TextEditingController(text: item.alternativeText);
  var captionController = TextEditingController(text: item.caption);
  return showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(builder: (alertContext) {
              return GestureDetector(
                onTap: () {},
                child: SimpleDialog(
                  contentPadding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
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
                                _buildImageSection(alertContext, item).p(4),
                                _buildInfoSection(alertContext, item).p(12),
                                PrimaryTextField(
                                  controller: filenameController,
                                  title: 'File Name',
                                ).px(16),
                                PrimaryTextField(
                                  controller: alternativeTextController,
                                  title: 'Alternative Text',
                                  descriptionText:
                                      'This text will be displayed if the assets can\'t be shown.',
                                ).p(16).py(8),
                                PrimaryTextField(
                                  controller: captionController,
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
                          buildHeader(context, 'Details'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      });
}

Stack _buildImageSection(context, Media item) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            color: Colors.grey[800],
            child: Image.network('${GlobalConfig.data.adminURL + item.url}'),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StrapiIconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(comingSoonSnackbar);
                  },
                  icon: 'assets/icons/delete.svg')
              .px(8),
          StrapiIconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(comingSoonSnackbar);
              },
              icon: 'assets/icons/download.svg'),
          StrapiIconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(comingSoonSnackbar);
                  },
                  icon: 'assets/icons/link.svg')
              .px(8),
          StrapiIconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(comingSoonSnackbar);
              },
              icon: 'assets/icons/crop.svg'),
        ],
      ).p(8),
    ],
  );
}

Container _buildInfoSection(context, Media item) {
  var parsedDetails = parseMediaDetails(item);
  return Container(
    decoration: BoxDecoration(
        color: neutral100, borderRadius: BorderRadius.circular(3)),
    child: Column(
      children: [
        Row(
          children: [
            _mediaLibraryItemInfoEntry(key: 'Size', val: parsedDetails.size),
            _mediaLibraryItemInfoEntry(
                key: 'Date', val: item.createdAt?.toString())
          ],
        ),
        16.heightBox,
        Row(
          children: [
            _mediaLibraryItemInfoEntry(
                key: 'Dimensions', val: parsedDetails.dimension),
            _mediaLibraryItemInfoEntry(
                key: 'Extension', val: parsedDetails.extension),
          ],
        ),
      ],
    ).p(16),
  );
}

Container buildHeader(BuildContext context, String title) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
        color: neutral100,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))
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

dynamic showAddLocaleDialog(context, SelectedLocale locale) {
  var localeController = TextEditingController(text: locale.code);
  var localeDisplayNameController = TextEditingController(text: locale.name);
  bool isDefault = locale.isDefault;
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
                        PrimaryTextField(
                          controller: localeController,
                          title: 'Locales',
                        ).px(16),
                        PrimaryTextField(
                          controller: localeDisplayNameController,
                          title: 'Locale Display Name',
                          descriptionText:
                              'Locale will be displayed under that name in the administration panel',
                        ).p(16).py(8),
                        Divider(
                          color: neutral500,
                        ),
                        Row(
                          children: [
                            StrapiCheckBox(
                              onChanged: (v) {},
                              value: isDefault,
                            ),
                            Text('Set as default locale',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          'One default locale is required, change it by selecting another one',
                          style: TextStyle(color: neutral500),
                        ).px(16),
                        16.heightBox,
                        Container(
                          decoration: BoxDecoration(
                              color: neutral100,
                              borderRadius: BorderRadius.circular(3)),
                          child: Row(
                            children: [
                              Expanded(child: PrimaryCancelGreySquareButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
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
                          ).p(16),
                        ),
                      ],
                    ).pOnly(top: 24),
                  ),
                  buildHeader(context, 'Edit a locale'),
                ],
              ),
            ),
          ],
        );
      });
}
