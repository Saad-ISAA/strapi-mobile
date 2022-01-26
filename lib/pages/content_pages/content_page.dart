import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/content_page_end_drawer.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/controllers/collectionTypeController.dart';
import 'package:strapi_flutter_cms/models/content_type.dart';
import 'package:strapi_flutter_cms/models/content_type_configuration.dart'
    as CTC;
import 'package:strapi_flutter_cms/pages/comming_soon_page.dart';
import 'package:strapi_flutter_cms/pages/content_pages/content_settings_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/messages.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

enum ContentListVew { LISTVIEW, GRIDVIEW }

class ContentPage extends StatefulWidget {
  const ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  GlobalKey<_ContentPageState> _scaffoldKey = GlobalKey();

  int _viewType = 1;

  List<ContentType> collectionTypes = [];
  List<ContentType> singleTypes = [];

  List<String> displayFields = [];
  ContentType selectedContentType;

  List<dynamic> data = [];
  CTC.ContentTypeConfiguration selectedContentTypeConfiguration;

  bool loading = true;

  void setContentType(ContentType newType) async {
    setState(() {
      selectedContentType = newType;
      loading = true;
    });

    _initializeDefaultDisplayFields();
    fetchCollectionType(newType.uid)
        .then((value) {
          data = value;
          print(data.length);
        })
        .catchError((err) => print(err))
        .whenComplete(() => setState(() {
              loading = false;
            }));

    fetchContentTypeConfiguration(newType.uid).then((value) {
      selectedContentTypeConfiguration = value;
    });
  }

  void initState() {
    fetchContentTypes().then((value) {
      print(value);
      setState(() {
        // print("content types fetched" + value.length.toString());
        // contentTypes = value;
        collectionTypes = value
            .filter((element) =>
                element.isDisplayed && element.kind == "collectionType")
            .toList();

        singleTypes = value
            .filter((element) =>
                element.isDisplayed && element.kind == "singleType")
            .toList();

        if (collectionTypes.length > 0) {
          setContentType(collectionTypes[0]);
        } else if (singleTypes.length > 0) {
          setContentType(singleTypes[0]);
        }
      });
    }).catchError((err) {
      print(err);
      print("caught errorrr");
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  void _initializeDefaultDisplayFields() {
    if (selectedContentType != null) {
      List<String> defaultDisplayFields = [];
      int i = 0;
      selectedContentType.attributes.forEach((key, value) {
        if (i <= 3) {
          var attribute = selectedContentType.attributes[key];
          if (attribute["type"] != "richtext" &&
              attribute["type"] != "component") defaultDisplayFields.add(key);
        }
        i += 1;
      });
      setState(() {
        displayFields = defaultDisplayFields;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral100,
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text('Content'),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContentPageSettings())),
              icon: Icon(Icons.settings),
            ),
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(Icons.menu),
              ).px(8),
            ),
          ]),
      endDrawer: buildContentDrawer(context,
          collectionTypes: collectionTypes,
          singleTypes: singleTypes,
          setContentType: setContentType),
      body: Container(
              child: loading
                  ? CustomSpinner()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '${selectedContentType.info.displayName}'
                            .text
                            .xl3
                            .bold
                            .make()
                            .pOnly(top: 8),
                        '${data.length} entries found'
                            .text
                            .lg
                            .color(neutral600)
                            .make(),
                        Row(
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: EdgeInsets.all(0),
                              height: 35,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(width: 0.3, color: neutral400),
                              ),
                              color: Colors.white,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/filter.svg',
                                    height: 14,
                                  ),
                                  8.widthBox,
                                  'Filters'.text.size(15).make()
                                ],
                              ).px(12),
                            ),
                            16.widthBox,
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  (_viewType == 0)
                                      ? _viewType = 1
                                      : _viewType = 0;
                                });
                              },
                              elevation: 0,
                              padding: EdgeInsets.all(0),
                              height: 35,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(width: 0.3, color: neutral400),
                              ),
                              color: Colors.white,
                              child: Text((_viewType == 0)
                                      ? 'View type: List'
                                      : 'View type: Grid')
                                  .px(12),
                            ),
                          ],
                        ),
                        12.heightBox,
                        Expanded(
                            child: data.length > 0
                                ? Card(
                                    margin: EdgeInsets.all(0),
                                    child: renderCollectionType(
                                        selectedContentType,
                                        data,
                                        List<String>.from(
                                            selectedContentTypeConfiguration
                                                ?.contentType?.layouts != null ? selectedContentTypeConfiguration?.contentType?.layouts['list']:[]),
                                        _viewType,
                                        selectedContentTypeConfiguration),
                                  )
                                : CommingSoonPage(
                                    message: 'No content found',
                                    showAppBar: false,
                                  )),
                        16.heightBox,
                      ],
                    ))
          .p(16),
    );
  }
}

Widget renderCollectionType(
  ContentType contentType,
  List<dynamic> collectionTypeData,
  List<String> displayFields,
  int viewType,
  CTC.ContentTypeConfiguration contentTypeConfiguration,
) {
  List<Map<String, dynamic>> data = [];

  collectionTypeData.forEach((collection) {
    Map<String, dynamic> row = {};
    displayFields.forEach((field) {
      var attribute = contentType.attributes[field];
      String value = "";
      String type = "string";
      if (attribute["type"] == "relation") {
        // if type == "relation"
        if (attribute["relationType"] == "oneToMany" ||
            attribute["relationType"] == "manyWay") {
          value = '${collection[field]["count"]} items';
        } else if (attribute["relationType"] == "manyToOne" ||
            attribute["relationType"] == "oneWay" ||
            attribute["relationType"] == "oneToOne") {
          var relationKey = contentTypeConfiguration
              .contentType.metadatas[field]['edit']['mainField'];
          value =
              '${collection[field] != null ? collection[field][relationKey] : ""}';
        } else {
          value = '';
        }
      } else if (attribute["type"] == "media") {
        value = collection[field] != null
            ? '${GlobalConfig.data.adminURL}${collection[field]['url']}'
            : null;
        type = "media";
      } else {
        value = '${collection[field]}';
      }
      row[field] = {
        "value": value,
        "type": type,
      };
    });
    data.add(row);
  });

  return (viewType == 0)
      ? ListView(
          shrinkWrap: true,
          children: collectionTypeData
              .map(
                (e) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: primary500,
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {},
                      isThreeLine: true,
                      title: Text(
                        "${e['id']}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Created at: ${DateFormat.yMd().add_jm().format(DateTime.parse(e['createdAt']))}\nUpdated at: ${DateFormat.yMd().add_jm().format(DateTime.parse(e['updatedAt']))}',
                        style: TextStyle(fontSize: 12),
                      ),

                      // children: displayFields
                      //     .map((displayField) => e[displayField]
                      //         .toString()
                      //         .text
                      //         .semiBold
                      //         .size(9)
                      //         .maxLines(3)
                      //         .ellipsis
                      //         .make()
                      //         .p(8))
                      //     .toList(),
                    ),
                    Divider()
                  ],
                ),
              )
              .toList())
      : Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: displayFields
                  .map((e) => Expanded(
                        flex: (e == 'id') ? 1 : 3,
                        child: e
                            .toUpperCase()
                            .text
                            .semiBold
                            .medium
                            .color(neutral700)
                            .make()
                            .p(8),
                      ))
                  .toList(),
            ),
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  children: data
                      .map(
                        (e) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: e.entries
                                .map((value) => Expanded(
                                    flex: (value.key == 'id') ? 1 : 3,
                                    child: value.value["type"] == "string"
                                        ? value.value["value"]
                                            .toString()
                                            .text
                                            .semiBold
                                            .size(9)
                                            .maxLines(3)
                                            .ellipsis
                                            .make()
                                            .p(8)
                                        : CircleAvatar(
                                            backgroundColor: primary500,
                                            backgroundImage: NetworkImage(
                                              value.value["value"],
                                            ),
                                          )))
                                .toList()),
                      )
                      .toList()),
            ),
          ],
        );
}

TextStyle legendStyle = TextStyle(color: neutral900, fontSize: 16);
TextStyle dialogText = TextStyle(color: neutral900, fontSize: 16);
