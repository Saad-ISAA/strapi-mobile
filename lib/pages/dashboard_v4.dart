import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Welcome on board'.text.bold.xl3.make(),
              12.heightBox,
              'Congrats! You are logged as the first administrator. To discover the powerful features provided by Strapi, we recommend you to create your first Content type!'
                  .text
                  .color(neutral600)
                  .make(),
              16.heightBox,
              LinkText(
                text: 'SEE MORE ON THE BLOG',
                onTap: () {},
              ),
              16.heightBox,
              PrimarySquareButton(
                text: 'Create your first content type ->',
                onPressed: () {},
                color: primary600,
              ),
              24.heightBox,
              DashboardCard(
                colorAccent: primary100,
                icon: 'docs.svg',
                title: 'Read the documentation',
                description:
                    'Discover the concepts, reference guides & tutorials.',
              ),
              DashboardCard(
                colorAccent: warning100,
                icon: 'code-example.svg',
                title: 'Code examples',
                description:
                    'Learn by testing the projects developed by community.',
              ).py(16),
              DashboardCard(
                colorAccent: secondary100,
                icon: 'tutorial.svg',
                title: 'Tutorial',
                description:
                    'Discover the concepts, reference guides & tutorials.',
              ),
              DashboardCard(
                colorAccent: alternative100,
                icon: 'blog.svg',
                title: 'Blog',
                description:
                    'Discover the concepts, reference guides & tutorials.',
              ).py(16),
              Card(
                margin: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Join the community'.text.xl.semiBold.make(),
                    4.heightBox,
                    'Discuss with team members, contributors and developers on different channels.'
                        .text
                        .color(neutral600)
                        .make(),
                    12.heightBox,
                    LinkText(
                      text: 'SEE OUR ROADMAP',
                      onTap: () {},
                    ),
                    24.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardSocialButton(
                          text: 'GitHub',
                          icon: 'github.svg',
                          onPressed: () {},
                        ),
                        DashboardSocialButton(
                          text: 'Discord',
                          icon: 'discord.svg',
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardSocialButton(
                          text: 'Reddit',
                          icon: 'reddit.svg',
                          onPressed: () {},
                        ),
                        DashboardSocialButton(
                          text: 'Twitter',
                          icon: 'twitter.svg',
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DashboardSocialButton(
                          text: 'Forum',
                          icon: 'forum.svg',
                          onPressed: () {},
                        ),
                        DashboardSocialButton(
                          text: 'Blog',
                          icon: 'strapi.svg',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ).p(16),
              ),
            ],
          ).p(24),
        ),
      ),
    );
  }
}

class DashboardSocialButton extends StatelessWidget {
  const DashboardSocialButton({
    @required this.text,
    @required this.icon,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final String text;
  final String icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      padding: EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/$icon',
            height: 26,
            width: 26,
          ),
          8.widthBox,
          text.text.lg.bold.make(),
        ],
      ),
    );
  }
}

class LinkText extends StatelessWidget {
  const LinkText({
    this.text,
    this.onTap,
    Key key,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: text.text.color(primary600).size(12).semiBold.make(),
        ),
        8.widthBox,
        Icon(
          Icons.screen_share_outlined,
          color: primary600,
        )
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key key,
    this.colorAccent,
    this.icon,
    this.title,
    this.description,
  }) : super(key: key);

  final Color colorAccent;
  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                color: colorAccent, borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: SvgPicture.asset('assets/icons/$icon'),
            ),
          ),
          16.widthBox,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.text.semiBold.make(),
                4.heightBox,
                description.text.size(15).color(neutral600).make(),
              ],
            ),
          )
        ],
      ).p(16),
    );
  }
}
