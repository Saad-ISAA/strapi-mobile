import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  VideoPlayerPage({this.video});

  final Map video;
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  void initState() {
    _controller = VideoPlayerController.network(widget.video['video']);
    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              widget.video['title'].toString().toUpperCase(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    _controller.play();
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
