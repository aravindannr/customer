import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _isPlaying = false;
          _controller.seekTo(Duration.zero);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  if (!_isPlaying)
                    IconButton(
                      icon: const Icon(Icons.play_circle_fill, size: 64),
                      onPressed: () {
                        setState(() {
                          _isPlaying = true;
                          _controller.play();
                        });
                      },
                    ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
