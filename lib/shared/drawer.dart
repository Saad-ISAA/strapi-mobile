import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/controllers/authController.dart';
import 'package:strapi_flutter_cms/models/content_type.dart';
import 'package:strapi_flutter_cms/pages/collection.dart';
import 'package:strapi_flutter_cms/pages/comming_soon_page.dart';
import 'package:strapi_flutter_cms/pages/content_pages/content_page.dart';
import 'package:strapi_flutter_cms/pages/login.dart';
import 'package:strapi_flutter_cms/pages/media_library_page.dart';
import 'package:strapi_flutter_cms/pages/profile_page.dart';
import 'package:strapi_flutter_cms/pages/settings.dart';
import 'package:strapi_flutter_cms/pages/training_videos_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:strapi_flutter_cms/shared/messages.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({this.contentTypes = const []});

  final List<ContentType> contentTypes;
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void initState() {
    super.initState();
  }

  int _currentTab = 1;

  // void logoutUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('token');
  //   prefs.remove('user');

  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
  // }

  void _changeHighlightedTab(int val) {
    setState(() {
      _currentTab = val;
    });
  }

  Widget buildDrawerRowEntry({String title, Function onTap}) {
    return InkWell(
      splashColor: Colors.white,
      highlightColor: Colors.black,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: drawerRowsColor,
              size: 7,
            ),
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      8.widthBox,
                      Container(
                        decoration: BoxDecoration(
                            color: primary600,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                          'assets/images/logo_white.png',
                          height: 25,
                        ).p(12),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          4.heightBox,
                          Text(
                            'Strapi Dashboard',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: neutral800,
                            ),
                          ),
                          2.heightBox,
                          Text(
                            'Workplace',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: neutral700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).p(16),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        16.heightBox,
                        _dawerEntryWithPrefixIcon(
                            val: 1,
                            icon: 'assets/icons/content-icon.svg',
                            onTap: () {
                              _changeHighlightedTab(1);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContentPage()));
                            },
                            text: 'Content'),
                        SizedBox(height: 48),
                        Text(
                          'PLUGINS',
                          style: TextStyle(
                              color: neutral600,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ).px(24),
                        16.heightBox,
                        _dawerEntryWithPrefixIcon(
                            val: 2,
                            icon: 'assets/icons/content-icon.svg',
                            onTap: () {
                              _changeHighlightedTab(2);
                              print("Tapped");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommingSoonPage(
                                            message:
                                                contentInDevelopmentMessage,
                                          )));
                            },
                            text: 'Builder'),
                        _dawerEntryWithPrefixIcon(
                            val: 3,
                            icon: 'assets/icons/media-library.svg',
                            onTap: () {
                              _changeHighlightedTab(3);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MediaLibraryPage()),
                              );
                            },
                            text: 'Media Library'),
                        // _dawerEntryWithPrefixIcon(
                        //     icon: 'assets/icons/info-alert.svg',
                        //     onTap: () {},
                        //     text: 'Documentation'),
                        SizedBox(height: 48),
                        Text(
                          'GENERAL',
                          style: TextStyle(
                              color: neutral600,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ).px(24),
                        16.heightBox,
                        _dawerEntryWithPrefixIcon(
                            val: 4,
                            icon: 'assets/icons/plugins-icons.svg',
                            onTap: () {
                              _changeHighlightedTab(4);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommingSoonPage(
                                            message:
                                                contentInDevelopmentMessage,
                                          )));
                            },
                            text: 'Plugins'),
                        _dawerEntryWithPrefixIcon(
                            val: 5,
                            icon: 'assets/icons/marketplace-icon.svg',
                            onTap: () {
                              _changeHighlightedTab(5);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommingSoonPage(
                                            message:
                                                contentInDevelopmentMessage,
                                          )));
                            },
                            text: 'Marketplace'),
                        _dawerEntryWithPrefixIcon(
                          val: 6,
                          icon: 'assets/icons/settings-icon.svg',
                          onTap: () {
                            _changeHighlightedTab(6);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()),
                            );
                          },
                          text: 'Settings',
                        ),
                        SizedBox(height: 32),

                        // buildDrawerRowEntry(
                        //   title: 'Chauffeur Bookings',
                        //   onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Collection(),
                        //     ),
                        //   ),
                        // ),
                        // buildDrawerRowEntry(
                        //     title: 'Form Fields', onTap: () {}),
                        // buildDrawerRowEntry(
                        //     title: 'Housekeeper Bookings', onTap: () {}),
                        // buildDrawerRowEntry(
                        //     title: 'Nurse Bookings', onTap: () {}),
                        // buildDrawerRowEntry(title: 'Users', onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),
              _dawerEntryWithPrefixIcon(
                  val: 7,
                  icon: 'assets/icons/logout.svg',
                  onTap: () {
                    _changeHighlightedTab(7);
                    logoutUser().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    });
                  },
                  text: 'Logout'),
              SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => ProfilePage()));
                    },
                    child: CircleAvatar(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [primary700, Colors.white])),
                        child: Center(
                          child: Text(
                            GlobalConfig.data.user["firstname"]
                                    .toString()
                                    .characters
                                    .first +
                                GlobalConfig.data.user["lastname"]
                                    .toString()
                                    .characters
                                    .first,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      minRadius: 20,
                      maxRadius: 20,
                    ),
                  ),
                  12.widthBox,
                  Text(
                    GlobalConfig.data.user["firstname"] +
                        " " +
                        GlobalConfig.data.user["lastname"],
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: neutral600)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ).px(16),
              // SizedBox(height: 5),

              //     style: TextStyle(
              //         color: white,
              //         fontSize: 15,
              //         fontWeight: FontWeight.w600)),
              // SizedBox(height: 5),
              // Text(user['email'], style: TextStyle(color: white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dawerEntryWithPrefixIcon(
      {String icon, String text, Function onTap, @required val}) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: (_currentTab == val) ? primary100 : null,
        splashColor: primary200,
        highlightColor: primary200,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              color: (_currentTab == val) ? primary600 : neutral500,
              height: 21,
              width: 21,
            ),
            12.widthBox,
            Text(
              text,
              style: TextStyle(
                color: (_currentTab == val) ? primary600 : neutral500,
                fontSize: 17,
              ),
            ),
          ],
        ).px(8),
      ).px(16),
    );
  }
}

Widget buildDrawerRowEntryWithCustomIcon(
    {String title, Function onTap, IconData icon}) {
  return InkWell(
    splashColor: primary100,
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: drawerRowsColor,
            size: 20,
          ),
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
