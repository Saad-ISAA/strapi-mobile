import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/pages/videoPlayerScreen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrainingVIdeosPage extends StatefulWidget {
  @override
  _TrainingVIdeosPageState createState() => _TrainingVIdeosPageState();
}

class _TrainingVIdeosPageState extends State<TrainingVIdeosPage> {
  List trainingVideos = [];
  bool loading = true;
  // TrainingVideo v1 = TrainingVideo(
  //     title: "Create Your first content-type",
  //     duration: "1:43",
  //     thumbnailUrl:
  //         'https://image.shutterstock.com/image-vector/video-pack-thumbnails-cover-photo-260nw-1457171108.jpg',
  //     videoUrl: "");
  // TrainingVideo v2 = TrainingVideo(
  //     title: "Fill your content with data",
  //     duration: "1:06",
  //     thumbnailUrl:
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTtgm2hvEBaru6vOEzBVsvznVjSB7QBQchhqQ&usqp=CAU",
  //     videoUrl: "");

  // TrainingVideo v3 = TrainingVideo(
  //     title: "Fetch data through the API",
  //     duration: "0:s44",
  //     thumbnailUrl:
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTtgm2hvEBaru6vOEzBVsvznVjSB7QBQchhqQ&usqp=CAU",
  //     videoUrl: "");

  void initState() {
    super.initState();
    fetchTrainingVideos();
  }

  void fetchTrainingVideos() async {
    var url = Uri.parse('https://strapi.io/videos');
    var jsonResponse = await http.get(url);
    if (jsonResponse.statusCode == 200) {
      List trainVideos = jsonDecode(jsonResponse.body);
      setState(() {
        trainingVideos = trainVideos;
        loading = false;
      });
    } else {
      print('videos fetch failed');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          loading
              ? (CircularProgressIndicator())
              : (_buildVideosList(trainingVideos)),
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

  Widget _buildVideosList(List trainingVideos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: trainingVideos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            elevation: 0,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(
                              video: trainingVideos[index],
                            )));
              },
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
                            trainingVideos[index]['preview'],
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
              title: Text(trainingVideos[index]['title']).text.bold.make(),
              // subtitle: Text(trainingVideos[index].duration).text.bold.make(),
            ),
          ),
        );
      },
      // children: ,
    );
  }
}
