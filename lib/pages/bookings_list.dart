import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/models/booking_entry.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

TextEditingController _searchQueryController = TextEditingController();
bool _isSearching = false;
String searchQuery = "Search query";

class BookingsList extends StatefulWidget {
  @override
  _BookingsListState createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  static final BookingEnrty firstEntry = BookingEnrty(
      id: 1,
      content: "Some Content",
      publishedAt: "Friday, October 23rd 2020 15:37",
      createdAt: "Friday, October 23rd 2020 15:37",
      isPublished: true);

  static final BookingEnrty secondEntry = BookingEnrty(
      id: 2,
      content: "Some Content",
      publishedAt: "N/A",
      createdAt: "Friday, October 23rd 2020 15:37",
      isPublished: false);

  List<BookingEnrty> bookingEntries = [firstEntry, secondEntry];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkNavyBlue,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: buttonColor,
          leading: _isSearching ? const BackButton() : Container(),
          title: _isSearching ? _buildSearchField() : _buildTitle(),
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
            SizedBox(height: 16),
            // Padding(
            //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Id',
            //         style: legendStyle,
            //       ),
            //       Text(
            //         'Content',
            //         style: legendStyle,
            //       ),
            //       Text(
            //         'Status',
            //         style: legendStyle,
            //       ),
            //       Text(
            //         'More',
            //         style: legendStyle,
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 8),
            ListView.builder(
                itemCount: bookingEntries.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 0.0),
                          child: ExpansionTile(
                            trailing: PopupMenuButton<String>(
                              onSelected: (String choice) {
                                if (choice == 'Delete') {
                                  setState(() {
                                    bookingEntries.removeAt(index);
                                  });
                                }
                              },
                              itemBuilder: (context) {
                                return DropDownItem.choices
                                    .map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Row(
                                      children: [
                                        Icon((choice == 'Edit')
                                            ? Icons.edit
                                            : Icons.delete),
                                        SizedBox(width: 8),
                                        Text(choice),
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${bookingEntries[index].id}'),
                                Text('${bookingEntries[index].content}'),
                                Container(
                                  height: 25,
                                  width: 75,
                                  padding: EdgeInsets.all(2),
                                  decoration: bookingEntries[index].isPublished
                                      ? BoxDecoration(
                                          color: Colors.green[50],
                                          border: Border.all(
                                              width: 1, color: Colors.green))
                                      : BoxDecoration(
                                          color: Colors.red[100],
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.redAccent),
                                        ),
                                  child: Center(
                                    child: bookingEntries[index].isPublished
                                        ? Text(
                                            'Published',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12),
                                          )
                                        : Text(
                                            'Unpublished',
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Text(
                                'Published at:  ${bookingEntries[index].publishedAt}',
                                style: TextStyle(
                                  color: darkNavyBlue,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Created at:  ${bookingEntries[index].createdAt}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ));
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Bookings',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 4),
        Text(
          '${bookingEntries.length} Entries found',
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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
                      activeColor: buttonColor,
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

  TextStyle legendStyle = TextStyle(color: white, fontSize: 16);
  TextStyle dialogText = TextStyle(color: drawerRowsColor, fontSize: 16);
}

// for more options dropdown on every tile
class DropDownItem {
  static const String edit = 'Edit';
  static const String delete = 'Delete';

  static const List<String> choices = <String>[edit, delete];
}
