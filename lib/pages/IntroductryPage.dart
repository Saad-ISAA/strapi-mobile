import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IntroductoryPage extends StatefulWidget {
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
    var url = Uri.parse(
        'https://strapi.io/api/blog-posts?_limit=2&_sort=publishedAt:desc');
    var response = await http.get(url);

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
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildIntroCard(),
            SizedBox(
              height: 15,
            ),
            loading ? (CircularProgressIndicator()) : (buildBlogsCard(blogs)),
            SizedBox(
              height: 10,
            ),
            _buildSeeAllBlogsButton(),
            SizedBox(
              height: 10,
            ),
            buildBottomOption(
                'Documentation',
                'Discover the concepts,reference guides and tutorials',
                Icon(
                  Icons.book,
                  size: 20,
                  color: strapiColor,
                )),
            buildBottomOption(
                'Code samples',
                'Learn by testing real projects developed the community',
                Icon(
                  Icons.code,
                  size: 20,
                  color: strapiColor,
                ))
          ],
        ),
      ),
    );
  }

  Widget buildBottomOption(String title, String subtitle, Icon icon) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: icon,
            subtitle: Text(
              subtitle,
              style: TextStyle(fontSize: 12),
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget buildIntroCard() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: strapiColor),
          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                'Hi ${GlobalConfig.data.user["firstname"]}',
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
        return Container(
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
                      color: strapiColor,
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
    return FlatButton(
      onPressed: () {},
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
            color: strapiColor,
          )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SEE MORE ON BLOGS',
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          )),
    );
  }
}
