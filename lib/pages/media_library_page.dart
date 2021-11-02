import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/checkbox.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/controllers/mediaLibraryController.dart';
import 'package:strapi_flutter_cms/models/media_library.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class MediaLibraryPage extends StatefulWidget {
  const MediaLibraryPage({Key key}) : super(key: key);

  @override
  _MediaLibraryPageState createState() => _MediaLibraryPageState();
}

class _MediaLibraryPageState extends State<MediaLibraryPage> {
  bool loading = true;
  List<Media> media = [];
  void initState() {
    loading = true;
    fetchMediaLibarary()
        .then((value) {
          setState(() {
            media = value;
          });
        })
        .catchError((err) => print(err))
        .whenComplete(() => setState(() {
              loading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Media Library'),
      ),
      floatingActionButton: _buildFLoatingActionButton(),
      body: Column(
        children: [
          '${media.length} items'.text.make(),
          12.heightBox,
          Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                            BorderSide(color: neutral300)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                    onPressed: () {},
                    child: StrapiCheckBox(
                      onChanged: (v) {},
                      value: false,
                    )),
              ),
              8.widthBox,
              SizedBox(
                height: 35,
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(
                          BorderSide(color: neutral300)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                  onPressed: () {},
                  child: Row(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 80,
                        child: DropdownButton(
                          onChanged: (v) {},
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Text('Sort by'),
                          value: null,
                          items: [
                            DropdownMenuItem(value: 1, child: Text('Name'))
                          ],
                        ),
                      )
                    ],
                  ).px(8),
                ),
              ),
              8.widthBox,
              SizedBox(
                height: 35,
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(
                          BorderSide(color: neutral300)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.filter_list_rounded,
                              color: neutral500, size: 18)
                          .px(8),
                      SizedBox(
                        height: 35,
                        width: 55,
                        child: DropdownButton(
                          onChanged: (v) {},
                          isExpanded: true,
                          icon: SizedBox(),
                          underline: SizedBox(),
                          hint: Text('Filters'),
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Name'),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text('Type'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).px(8),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 35,
                height: 35,
                child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                            BorderSide(color: neutral300)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                    onPressed: () {},
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      color: neutral500,
                      width: 17,
                    )),
              ),
            ],
          ),
          24.heightBox,
          Expanded(
              child: loading
                  ? CustomSpinner()
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: media.length,
                      gridDelegate: gridDelegate,
                      itemBuilder: (context, index) {
                        var item = media[index];
                        var parsedDetails = parseMediaDetails(item);
                        return GestureDetector(
                          onTap: () =>
                              showMediaLibraryInfoDialog(context, item),
                          child: Card(
                            elevation: 1.5,
                            margin: EdgeInsets.all(0),
                            child: SizedBox(
                              width: (context.screenWidth - 64) / 2,
                              height: (context.screenWidth - 64) / 2,
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4)),
                                          child: Container(
                                            color: Colors.grey[800],
                                            child: Image.network(
                                                GlobalConfig.data.adminURL +
                                                    item.url,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 1,
                                        thickness: 1.5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              '${item.name}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ).py(8),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300]
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            height: 16,
                                            child: (parsedDetails.type !=
                                                        'IMAGE' ||
                                                    parsedDetails.type != 'VID')
                                                ? Text(
                                                    parsedDetails.type,
                                                    style: TextStyle(
                                                        color: neutral700,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ).px(3)
                                                : SvgPicture.asset(
                                                    'assets/icons/documentation.svg',
                                                    height: 11,
                                                    color: neutral500,
                                                  ),
                                          )
                                        ],
                                      ).px(8),
                                      Text(
                                        '${parsedDetails.extension} - ${parsedDetails.dimension} - ${parsedDetails.size}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11, color: neutral500),
                                      ).px(8),
                                    ],
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: StrapiCheckBox(
                                        onChanged: (v) {}, value: true),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            side: MaterialStateProperty.all(
                                                BorderSide(color: neutral500)),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.all(0))),
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.edit,
                                          size: 15,
                                          color: neutral500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
        ],
      ).p(16),
    );
  }

  FloatingActionButton _buildFLoatingActionButton() {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () {},
      backgroundColor: primary600,
      child: Icon(Icons.add),
      tooltip: 'Add Asset',
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 22,
  );
}
