import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/controllers/collectionTypeController.dart';
import 'package:strapi_flutter_cms/models/content_type.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _searchQueryController = TextEditingController();
bool _isSearching = false;
String searchQuery = "Search query";

class Collection extends StatefulWidget {
  Collection({this.contentType});
  final ContentType contentType;

  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  List contentTypes = [];
  List<String> keys = [];
  bool loading = false;
  Map filters = {};

  List<dynamic> collectionTypeData = [];
  List<String> displayFields = [];

  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    fetchCollectionType(widget.contentType.uid)
        .then((value) {
          print(value);
          collectionTypeData = value;
        })
        .catchError((err) => print(err))
        .whenComplete(() => setState(() {
              loading = false;
            }));
    _initializeDefaultDisplayFields();
  }

  void _initializeDefaultDisplayFields() {
    List<String> defaultDisplayFields = [];

    int i = 0;
    widget.contentType.attributes.forEach((key, value) {
      if (i <= 3) {
        var attribute = widget.contentType.attributes[key];
        if (attribute["type"] != "richtext" && attribute["type"] != "component")
          defaultDisplayFields.add(key);
      }
      i += 1;
    });

    setState(() {
      displayFields = defaultDisplayFields;
    });
  }

  Future<void> _getFilters(var adminURL, String token) async {
    var url = Uri.parse(
        '$adminURL/content-manager/content-types/${widget.contentType.uid}/configuration');

    print(url);
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List selectedFilters =
          jsonResponse["data"]["contentType"]["layouts"]["list"];
      print(selectedFilters);
      // List availableFilters = [];

      List availableFilters =
          jsonResponse["data"]["contentType"]["metadatas"].keys.toList();
      // jsonResponse["data"]["contentType"]["layouts"]["edit"].forEach((edit) {
      //   edit.forEach((value) {
      //     if (value["size"] <= 6) {
      //       availableFilters.add(value["name"]);
      //     }
      //   });
      // });
      print(availableFilters);
      availableFilters.forEach((element) {
        filters.putIfAbsent(element, () => false);
      });

      selectedFilters.forEach((element) {
        filters.update(element, (value) => true);
      });
    } else {
      print('data fetch failed');
    }
  }

  // void _getContentTypeData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String adminURL = prefs.getString('adminURL');
  //   String token = prefs.getString('token');
  //   var url = Uri.parse('${adminURL}/${widget.data['url']}');

  //   print('${adminURL}/${widget.data['url']}');
  //   var response =
  //       await http.get(url, headers: {'Authorization': 'Bearer $token'});

  //   await _getFilters(adminURL, token);

  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     Map anyContentType = jsonResponse[0];

  //     setState(() {
  //       contentTypes = jsonResponse["results"];
  //       if (contentTypes.isNotEmpty) {
  //         keys = contentTypes[0].keys.toList();
  //       }
  //       loading = false;
  //     });
  //   } else {
  //     print('data fetch failed');
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: strapiColor,
          // leading: _isSearching ? const BackButton() : Container(),
          title: _isSearching
              ? _buildSearchField()
              : _buildTitle(widget.contentType.info.displayName),
          actions: _buildActions(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
          tooltip: 'Add Booking',
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            loading
                ? Expanded(
                    child: Center(
                      child: CustomSpinner(),
                    ),
                  )
                : Expanded(
                    child: collectionTypeData.length > 0
                        ? renderCollectionTypes(widget.contentType,
                            collectionTypeData, displayFields)
                        : Center(
                            child: Text(
                              'No content found',
                              style: TextStyle(color: white),
                            ),
                          ),
                  )
          ],
        ));
  }

  Widget _buildTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 4),
        Text(
          '${contentTypes.length} Entries found',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.clear,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: _startSearch,
          ),
          SizedBox(width: 16),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
            ),
            onPressed: () {
              showFilterDiag(context).then((value) => setState(() {}));
            },
          ),
        ],
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Future<dynamic> showFilterDiag(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: darkNavyBlue,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Displayed Fields",
                    style: TextStyle(fontSize: 20, color: white),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: List.generate(
                            filters.length,
                            (index) => CheckboxListTile(
                              activeColor: strapiColor,
                              title: Text(
                                filters.keys.toList()[index],
                                style: dialogText,
                              ),
                              value: filters[filters.keys.toList()[index]],
                              onChanged: (value) {
                                setState(() {
                                  filters[filters.keys.toList()[index]] = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Apply"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Widget renderCollectionTypes(ContentType contentType,
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
          // for (int i = 0; i < collection[field].length; i++) {
          //   var key = collection[field].keys.toList()[i];
          //   var v = collection[field][key];
          //   print(key);
          //   if (value.runtimeType != Map) {
          //     value = '$v';
          //     break;
          //   } else {
          //     value = '${collection[field]["id"]}';
          //   }
          // }

          value = '${collection[field]["id"]}';
        } else {
          value = 'cell';
        }
      } else if (attribute["type"] == "media") {
        value = 'cell';
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

// for more options dropdown on every tile
class DropDownItem {
  static const String edit = 'Edit';
  static const String delete = 'Delete';

  static const List<String> choices = <String>[edit, delete];
}

TextStyle legendStyle = TextStyle(color: neutral900, fontSize: 16);
TextStyle dialogText = TextStyle(color: neutral900, fontSize: 16);
