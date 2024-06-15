import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/custom_logo_spinner.dart';

class VideoAdSection extends StatefulWidget {
  const VideoAdSection({
    super.key,
    required this.videoController,
    required this.page,
    required this.isShow,
  });

  final VideoPlayerController videoController;
  final Widget page;
  final bool isShow;

  @override
  State<VideoAdSection> createState() => _VideoAdSectionState();
}

class _VideoAdSectionState extends State<VideoAdSection> {
  @override
  Widget build(BuildContext context) {
    return widget.isShow
        ? AspectRatio(
            aspectRatio: widget.videoController.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(
                  widget.videoController,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color.fromARGB(211, 0, 0, 0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lorem ipsum ",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          "Lorem ipsum is a placeholder text ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : AspectRatio(
            aspectRatio: widget.videoController.value.aspectRatio,
            child: const Center(
              child: CustomLogoSpinner(
                oneSize: 10,
                roundSize: 30,
                color: Colors.white,
              ),
            ),
          );
  }
}
