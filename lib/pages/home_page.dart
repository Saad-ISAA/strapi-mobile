import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: blue,
                height: 210,
                //padding: EdgeInsets.only(top: 16, left: 32, bottom: 8),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 8,
                    ),
                    SizedBox(
                      width: 140,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/logo_white.png',
                            height: 30,
                          ),
                          SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13.0),
                            child: Text(
                              'strapi',
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 0),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                      minRadius: 40,
                      maxRadius: 41,
                    ),
                    SizedBox(height: 8),
                    Text('John Doe',
                        style: TextStyle(
                            color: white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 5),
                    Text('johndoe@gmail.com', style: TextStyle(color: white)),
                    SizedBox(height: 16)
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 234,
                padding: EdgeInsets.all(24),
                color: darkNavyBlue,
                child: SingleChildScrollView(
                  child: Column(
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
                          title: 'Chauffeur Bookings', onTap: () {}),
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
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Drag right to view drawer'),
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
}
