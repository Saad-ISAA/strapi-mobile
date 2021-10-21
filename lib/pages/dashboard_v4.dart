import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: 'SEE MORE ON THE BLOG'
                        .text
                        .color(primary600)
                        .size(12)
                        .semiBold
                        .make(),
                  ),
                  8.widthBox,
                  Icon(
                    Icons.screen_share_outlined,
                    color: primary600,
                  )
                ],
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
                colorAccent: primary100,
                icon: 'code-example.svg',
                title: 'Read the documentation',
                description:
                    'Discover the concepts, reference guides & tutorials.',
              ).py(16),
              DashboardCard(
                colorAccent: primary100,
                icon: 'tutorial.svg',
                title: 'Read the documentation',
                description:
                    'Discover the concepts, reference guides & tutorials.',
              ),
              DashboardCard(
                colorAccent: primary100,
                icon: 'blog.svg',
                title: 'Read the documentation',
                description:
                    'Discover the concepts, reference guides & tutorials.',
              ).py(16),
            ],
          ).p(24),
        ),
      ),
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
                description.text.size(16).color(neutral600).make(),
              ],
            ),
          )
        ],
      ).p(16),
    );
  }
}
