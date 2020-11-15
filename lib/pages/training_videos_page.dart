import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/models/training_videos.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class TrainingVIdeosPage extends StatefulWidget {
  @override
  _TrainingVIdeosPageState createState() => _TrainingVIdeosPageState();
}

class _TrainingVIdeosPageState extends State<TrainingVIdeosPage> {
  TrainingVideo v1 = TrainingVideo(
      title: "Create Your first content-type",
      duration: "1:43",
      thumbnailUrl:
          'https://image.shutterstock.com/image-vector/video-pack-thumbnails-cover-photo-260nw-1457171108.jpg',
      videoUrl: "");
  TrainingVideo v2 = TrainingVideo(
      title: "Fill your content with data",
      duration: "1:06",
      thumbnailUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTtgm2hvEBaru6vOEzBVsvznVjSB7QBQchhqQ&usqp=CAU",
      videoUrl: "");

  TrainingVideo v3 = TrainingVideo(
      title: "Fetch data through the API",
      duration: "0:s44",
      thumbnailUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTtgm2hvEBaru6vOEzBVsvznVjSB7QBQchhqQ&usqp=CAU",
      videoUrl: "");

  @override
  Widget build(BuildContext context) {
    List<TrainingVideo> trainingVideos = [v1, v2, v3];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Training Videos'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GET STARTED VIDEOS').text.bold.gray700.size(16).make(),
              Text('0% COMPLETED').text.bold.green400.size(16).make(),
            ],
          ),
          SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            itemCount: trainingVideos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: SizedBox(
                        height: 65,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  trainingVideos[index].thumbnailUrl,
                                ),
                              )),
                            ),
                            Center(
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: IconButton(
                                    padding: EdgeInsets.all(2),
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {}),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    title: Text(trainingVideos[index].title).text.bold.make(),
                    subtitle:
                        Text(trainingVideos[index].duration).text.bold.make(),
                  ),
                ),
              );
            },
            // children: ,
          ),
          Spacer(),
          Divider(),
          SizedBox(
            height: 35,
            child: ListTile(
              leading: Icon(
                Icons.book,
                size: 20,
              ),
              title: Text('Documentation').text.size(16).gray600.make(),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              leading: Icon(
                Icons.file_copy_outlined,
                size: 20,
              ),
              title: Text('Cheat Sheet').text.size(16).gray600.make(),
              onTap: () {},
            ),
          ),
          SizedBox(height: 8),
        ],
      ).p(16),
    );
  }
}
