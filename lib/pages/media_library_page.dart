import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class MediaLibraryPage extends StatefulWidget {
  const MediaLibraryPage({Key key}) : super(key: key);

  @override
  _MediaLibraryPageState createState() => _MediaLibraryPageState();
}

class _MediaLibraryPageState extends State<MediaLibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Media Library'),
      ),
      floatingActionButton: _buildFLoatingActionButton(),
      body: Column(
        children: [
          16.heightBox,
          Expanded(
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 8,
                  gridDelegate: gridDelegate,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => showMediaLibraryInfoDialog(context),
                      child: SizedBox(
                        width: (context.screenWidth - 64) / 2,
                        height: (context.screenWidth - 64) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Container(
                                  color: Colors.grey[800],
                                  child: Image.asset(
                                      'assets/images/placeholder.png'),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Image $index',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ).py(8),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300].withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 16,
                                  child: Text(
                                    'IMAGE',
                                    style: TextStyle(
                                        color: neutral500,
                                        fontWeight: FontWeight.bold),
                                  ).px(3),
                                )
                              ],
                            ),
                            Text(
                              'PNG - 2880x1800 - 363KB',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13, color: neutral500),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ).p(16),
    );
  }

  FloatingActionButton _buildFLoatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: blue,
      child: Icon(Icons.add),
      tooltip: 'Add Asset',
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 22,
  );
}
