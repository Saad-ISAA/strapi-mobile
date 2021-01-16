import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/blogs.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntroductoryPage extends StatefulWidget {
  IntroductoryPage({this.user});
  final Map user;
  @override
  _IntroductoryPageState createState() => _IntroductoryPageState();
}

class _IntroductoryPageState extends State<IntroductoryPage> {
  List blogs = [];
  bool loading = true;

  void initState() {
    super.initState();

    _getCurrentBlogs();
  }

  void _getCurrentBlogs() async {
    var response = await http.get(
        'https://strapi.io/api/blog-posts?_limit=2&_sort=publishedAt:desc');

    if (response.statusCode == 200) {
      List responseBody = jsonDecode(response.body);
      setState(() {
        blogs = responseBody;
      });

      print(blogs);
    } else {
      print('blogs fetch failed');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildIntroCard(),
            SizedBox(
              height: 15,
            ),
            loading ? (CircularProgressIndicator()) : (buildBlogsCard(blogs)),
            _buildSeeAllBlogsButton()
          ],
        ),
      ),
    );
  }

  Widget buildIntroCard() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.amber[400],
                width: 4,
              ))),
              child: Text(
                'Hi ${widget.user['firstname'].toString()}!',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'We hope you are making progress on your project... Feel free to read the latest new about strapi',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlogsCard(List blogs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: blogs.map((blog) {
        return Card(
          elevation: 5,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    blog['seo']['metaDescription'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSeeAllBlogsButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      // width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BlogsPage()));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: darkNavyBlue,
        child: Text(
          'SEE MORE ON BLOGS',
          style: TextStyle(
            color: strapiColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
