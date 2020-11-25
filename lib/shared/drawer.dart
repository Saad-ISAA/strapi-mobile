import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:strapi_flutter_cms/pages/bookings_list.dart';
import 'package:strapi_flutter_cms/pages/training_videos_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

getDrawer(context) {
  return Drawer(
    child: Container(
      color: strapiColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: DrawerHeader(
              decoration: BoxDecoration(color: strapiColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            'assets/images/logo_white.png',
                            height: 15,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'strapi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'),
                        minRadius: 30,
                        maxRadius: 30,
                      ),
                      SizedBox(height: 5),
                      Text('John Doe',
                          style: TextStyle(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 5),
                      Text('johndoe@gmail.com', style: TextStyle(color: white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(24),
              color: darkNavyBlue,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'COLLECTION TYPES',
                            style: TextStyle(
                                color: Colors.white38,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white38,
                            size: 19,
                          ),
                        ],
                      ),
                      buildDrawerRowEntry(
                        title: 'Chauffeur Bookings',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingsList(),
                          ),
                        ),
                      ),
                      buildDrawerRowEntry(title: 'Form Fields', onTap: () {}),
                      buildDrawerRowEntry(
                          title: 'Housekeeper Bookings', onTap: () {}),
                      buildDrawerRowEntry(
                          title: 'Nurse Bookings', onTap: () {}),
                      buildDrawerRowEntry(title: 'Users', onTap: () {}),
                      SizedBox(height: 48),
                      Text(
                        'PLUGINS',
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      buildDrawerRowEntryWithCustomIcon(
                          title: 'Content-Types Builder',
                          onTap: () {},
                          icon: Icons.brush),
                      buildDrawerRowEntryWithCustomIcon(
                          title: 'Media Library',
                          onTap: () {},
                          icon: Icons.cloud_upload),
                      buildDrawerRowEntryWithCustomIcon(
                          title: 'Training',
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrainingVIdeosPage(),
                                ),
                              ),
                          icon: Icons.cloud_upload),
                      SizedBox(height: 48),
                      Text(
                        'GENERAL',
                        style: TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      buildDrawerRowEntryWithCustomIcon(
                        title: 'Marketplace',
                        onTap: () {},
                        icon: Icons.local_grocery_store,
                      ),
                      buildDrawerRowEntryWithCustomIcon(
                          title: 'Plugins', onTap: () {}, icon: Icons.storage),
                      buildDrawerRowEntryWithCustomIcon(
                          title: 'Settings',
                          onTap: () {},
                          icon: Icons.settings),
                      buildDrawerRowEntryWithCustomIcon(
                          title: 'Logout', onTap: () {}, icon: Icons.logout),
                      SizedBox(height: 32),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDrawerRowEntry({String title, Function onTap}) {
  return InkWell(
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

Widget buildDrawerRowEntryWithCustomIcon(
    {String title, Function onTap, IconData icon}) {
  return InkWell(
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
