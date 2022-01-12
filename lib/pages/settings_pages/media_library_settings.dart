import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/mediaLibraryController.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

class MediaLibrarySettingsPage extends StatefulWidget {
  const MediaLibrarySettingsPage({Key key}) : super(key: key);

  @override
  State<MediaLibrarySettingsPage> createState() =>
      _MediaLibrarySettingsPageState();
}

class _MediaLibrarySettingsPageState extends State<MediaLibrarySettingsPage> {
  bool _responsiveFriendlyUpload;
  bool _sizeOptimization;
  bool _autoOrientation;
  bool loading = true;

  void initState() {
    fetchMediaLibrarySettings()
        .then((value) {
          setState(() {
            _sizeOptimization = value["sizeOptimization"];
            _responsiveFriendlyUpload = value["responsiveDimensions"];
          });
        })
        .catchError((err) => print(err))
        .whenComplete(() {
          setState(() {
            loading = false;
          });
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? CustomSpinner()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Media Library - Settings'.text.xl2.semiBold.make(),
                2.heightBox,
                'Configure the settings for media library'
                    .text
                    .medium
                    .color(neutral500)
                    .make(),
                16.heightBox,
                Card(
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'IMAGE'.text.color(neutral500).make(),
                      24.heightBox,
                      Text('Enable responsive friendly upload',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      StrapiSwitch(
                        val: _responsiveFriendlyUpload,
                        onOffPress: () {
                          setState(() {
                            _responsiveFriendlyUpload = false;
                          });
                        },
                        onOnPress: () {
                          setState(() {
                            _responsiveFriendlyUpload = true;
                          });
                        },
                      ),
                      'It automatically generates size variants of the uploaded asset.'
                          .text
                          .size(14)
                          .color(neutral400)
                          .make(),
                      24.heightBox,
                      Text('Enable size optimization (without quality loss)',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      StrapiSwitch(
                        val: _sizeOptimization,
                        onOffPress: () {
                          setState(() {
                            _sizeOptimization = false;
                          });
                        },
                        onOnPress: () {
                          setState(() {
                            _sizeOptimization = true;
                          });
                        },
                      ),
                      24.heightBox,
                      Text('Enable auto orientation',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      StrapiSwitch(
                        val: _autoOrientation,
                        onOffPress: () {
                          setState(() {
                            _autoOrientation = false;
                          });
                        },
                        onOnPress: () {
                          setState(() {
                            _autoOrientation = true;
                          });
                        },
                      ),
                      'Automatically rotate image according to EXIF tag.'
                          .text
                          .size(14)
                          .color(neutral400)
                          .make(),
                    ],
                  ).p(16),
                ),
                Spacer(),
                PrimarySquareButton(
                  color: success500,
                  text: 'Save',
                ),
                PrimaryCancelGreySquareButton(
                  onPressed: () {},
                )
              ],
            ).p(24),
    );
  }
}
