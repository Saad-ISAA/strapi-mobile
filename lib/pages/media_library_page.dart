import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'package:strapi_flutter_cms/controllers/mediaLibraryController.dart';
import 'package:strapi_flutter_cms/models/media_library.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class MediaLibraryPage extends StatefulWidget {
  const MediaLibraryPage({Key key}) : super(key: key);

  @override
  _MediaLibraryPageState createState() => _MediaLibraryPageState();
}

class _MediaLibraryPageState extends State<MediaLibraryPage> {
  bool loading = true;
  List<Media> media = [];
  void initState() {
    loading = true;
    fetchMediaLibarary()
        .then((value) {
          setState(() {
            media = value;
          });
        })
        .catchError((err) => print(err))
        .whenComplete(() => setState(() {
              loading = false;
            }));
    super.initState();
  }

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
              child: loading
                  ? CustomSpinner()
                  : GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: media.length,
                      gridDelegate: gridDelegate,
                      itemBuilder: (context, index) {
                        var item = media[index];
                        var parsedDetails = parseMediaDetails(item);
                        return GestureDetector(
                          onTap: () =>
                              showMediaLibraryInfoDialog(context, item),
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
                                      child: Image.network(
                                          GlobalConfig.data.adminURL +
                                              item.url),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${item.name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ).py(8),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.grey[300].withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      height: 16,
                                      child: Text(
                                        parsedDetails.type,
                                        style: TextStyle(
                                            color: neutral500,
                                            fontWeight: FontWeight.bold),
                                      ).px(3),
                                    )
                                  ],
                                ),
                                Text(
                                  '${parsedDetails.extension} - ${parsedDetails.dimension} - ${parsedDetails.size}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13, color: neutral500),
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
