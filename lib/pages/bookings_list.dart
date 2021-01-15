import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strapi_flutter_cms/models/booking_entry.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _searchQueryController = TextEditingController();
bool _isSearching = false;
String searchQuery = "Search query";

class BookingsList extends StatefulWidget {
  BookingsList({this.drawerData, this.user, this.data});
  final List drawerData;
  final Map user;
  final Map data;

  @override
  _BookingsListState createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  List contentTypes = [];
  List<String> keys = [];
  bool loading = false;

  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    _getContentTypeData();
  }

  void _getContentTypeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String adminURL = prefs.getString('adminURL');
    String token = prefs.getString('token');

    print('http://${adminURL}/${widget.data['url']}');
    var response = await http.get('http://${adminURL}/${widget.data['url']}',
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Map anyContentType = jsonResponse[0];

      setState(() {
        contentTypes = jsonResponse;
        keys = anyContentType.keys.toList();
        loading = false;
      });
    } else {
      print('data fetch failed');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkNavyBlue,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: strapiColor,
          // leading: _isSearching ? const BackButton() : Container(),
          title: _isSearching
              ? _buildSearchField()
              : _buildTitle(widget.data['title']),
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
                ? (Center(
                    child: CircularProgressIndicator(),
                  ))
                : (Expanded(
                    child: contentTypes.length > 0
                        ? (renderCollectionTypes())
                        : (Text(
                            'No content found',
                            style: TextStyle(color: white),
                          )),
                  ))

            // ListView.builder(
            //     itemCount: bookingEntries.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            // return Padding(
            //   padding: const EdgeInsets.only(bottom: 4.0),
            //   child: SizedBox(
            //     child: Card(
            //       elevation: 5,
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 6.0, right: 0.0),
            //         child: ExpansionTile(
            //           trailing: PopupMenuButton<String>(
            //             onSelected: (String choice) {
            //               if (choice == 'Delete') {
            //                 setState(() {
            //                   bookingEntries.removeAt(index);
            //                 });
            //               }
            //             },
            //             itemBuilder: (context) {
            //               return DropDownItem.choices
            //                   .map((String choice) {
            //                 return PopupMenuItem<String>(
            //                   value: choice,
            //                   child: Row(
            //                     children: [
            //                       Icon((choice == 'Edit')
            //                           ? Icons.edit
            //                           : Icons.delete),
            //                       SizedBox(width: 8),
            //                       Text(choice),
            //                     ],
            //                   ),
            //                 );
            //               }).toList();
            //             },
            //           ),
            //           title: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text('${bookingEntries[index].id}'),
            //               Text('${bookingEntries[index].content}'),
            //               Container(
            //                 height: 25,
            //                 width: 75,
            //                 padding: EdgeInsets.all(2),
            //                 decoration: bookingEntries[index].isPublished
            //                     ? BoxDecoration(
            //                         color: Colors.green[50],
            //                         border: Border.all(
            //                             width: 1, color: Colors.green))
            //                     : BoxDecoration(
            //                         color: Colors.red[100],
            //                         border: Border.all(
            //                             width: 1,
            //                             color: Colors.redAccent),
            //                       ),
            //                 child: Center(
            //                   child: bookingEntries[index].isPublished
            //                       ? Text(
            //                           'Published',
            //                           style: TextStyle(
            //                               color: Colors.green,
            //                               fontSize: 12),
            //                         )
            //                       : Text(
            //                           'Unpublished',
            //                           style: TextStyle(
            //                               color: Colors.redAccent,
            //                               fontSize: 12),
            //                         ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           children: <Widget>[
            //             Text(
            //               'Published at:  ${bookingEntries[index].publishedAt}',
            //               style: TextStyle(
            //                 color: darkNavyBlue,
            //                 fontSize: 16,
            //               ),
            //             ),
            //             SizedBox(height: 5),
            //             Text(
            //               'Created at:  ${bookingEntries[index].createdAt}',
            //               style: TextStyle(
            //                 color: Colors.grey,
            //                 fontSize: 16,
            //               ),
            //             ),
            //             SizedBox(height: 16),
            //             SizedBox(height: 8),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // );
            //     })
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
              showFilterDiag(context);
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

  bool showContent = true;
  bool showCreatedAt = true;
  bool showID = true;
  bool showPublishedAt = true;
  bool showTesting = false;
  bool showTestingAgain = false;
  bool showTextField = false;
  bool showUpdatedAt = false;

  dynamic showFilterDiag(context) {
    return showDialog(
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
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Content',
                        style: dialogText,
                      ),
                      value: showContent,
                      onChanged: (value) {
                        setState(() {
                          showContent = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Created At',
                        style: dialogText,
                      ),
                      value: showCreatedAt,
                      onChanged: (value) {
                        setState(() {
                          showCreatedAt = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'ID',
                        style: dialogText,
                      ),
                      value: showID,
                      onChanged: (value) {
                        setState(() {
                          showID = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Published At',
                        style: dialogText,
                      ),
                      value: showPublishedAt,
                      onChanged: (value) {
                        setState(() {
                          showPublishedAt = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Testing',
                        style: dialogText,
                      ),
                      value: showTesting,
                      onChanged: (value) {
                        setState(() {
                          showTesting = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Testing Again',
                        style: dialogText,
                      ),
                      value: showTestingAgain,
                      onChanged: (value) {
                        setState(() {
                          showTestingAgain = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Text Field',
                        style: dialogText,
                      ),
                      value: showTextField,
                      onChanged: (value) {
                        setState(() {
                          showTextField = value;
                        });
                      }),
                  CheckboxListTile(
                      activeColor: strapiColor,
                      title: Text(
                        'Updated At',
                        style: dialogText,
                      ),
                      value: showUpdatedAt,
                      onChanged: (value) {
                        setState(() {
                          showUpdatedAt = value;
                        });
                      }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ListView renderCollectionTypes() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: contentTypes.length,
      itemBuilder: (context, index) {
        Map item = contentTypes[index];
        var randomField = item[keys[1]];
        return Container(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'key: ${keys[1]}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'value: $randomField',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )),
          ),
        ));
      },
    );
  }

  TextStyle legendStyle = TextStyle(color: white, fontSize: 16);
  TextStyle dialogText = TextStyle(color: drawerRowsColor, fontSize: 16);
}

// for more options dropdown on every tile
class DropDownItem {
  static const String edit = 'Edit';
  static const String delete = 'Delete';

  static const List<String> choices = <String>[edit, delete];
}
