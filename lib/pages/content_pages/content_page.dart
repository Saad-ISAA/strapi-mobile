import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/content_page_end_drawer.dart';
import 'package:strapi_flutter_cms/controllers/collectionTypeController.dart';
import 'package:strapi_flutter_cms/models/content_type.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/messages.dart';
import 'package:velocity_x/velocity_x.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  GlobalKey<_ContentPageState> _scaffoldKey = GlobalKey();

  List<ContentType> collectionTypes = [];
  List<ContentType> singleTypes = [];

  List<String> displayFields = [];
  ContentType selectedContentType;
  List<dynamic> data = [];

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
    }).whenComplete(() {});
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
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text('Content'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(Icons.menu),
              ).px(16),
            ),
          ]),
      endDrawer: buildContentDrawer(context,
          collectionTypes: collectionTypes,
          singleTypes: singleTypes,
          setContentType: setContentType),
      body: Container(
        child: loading
            ? CustomSpinner()
            : data.length > 0
                ? Column(
                    children: [
                      '${selectedContentType.info.label}'
                          .text
                          .xl3
                          .bold
                          .make()
                          .pOnly(top: 10),
                      Divider(),
                      Expanded(
                        child: renderCollectionType(
                            selectedContentType, data, displayFields),
                      )
                    ],
                  )
                : Center(
                    child: Text(
                      noContentAvailableMessage,
                    ),
                  ),
      ),
    );
  }
}

Widget renderCollectionType(ContentType contentType,
    List<dynamic> collectionTypeData, List<String> displayFields) {
  List<DataRow> dataRows = [];

  collectionTypeData.forEach((collection) {
    List<DataCell> dataCells = [];
    displayFields.forEach((field) {
      var attribute = contentType.attributes[field];
      String value = "";
      if (attribute["type"] == "relation") {
        // if type == "relation"
        if (attribute["relationType"] == "oneToMany" ||
            attribute["relationType"] == "manyWay") {
          value = '${collection[field]["count"]} items';
        } else if (attribute["relationType"] == "manyToOne" ||
            attribute["relationType"] == "oneWay") {
          print(collection);
          print(field);
          value = '${collection[field] != null ? collection[field]["id"] : ""}';
        } else {
          value = '';
        }
      } else if (attribute["type"] == "media") {
        value = '';
      } else {
        value = '${collection[field]}';
      }
      dataCells.add(DataCell(Text(
        value,
        style: legendStyle,
      )));
    });
    dataRows.add(DataRow(cells: dataCells));
  });

  return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: DataTable(
              columns: displayFields
                  .map((e) => DataColumn(
                          label: Text(
                        e,
                        style: dialogText,
                      )))
                  .toList(),
              rows: dataRows)));
}

TextStyle legendStyle = TextStyle(color: neutral900, fontSize: 16);
TextStyle dialogText = TextStyle(color: neutral900, fontSize: 16);
