import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String? url;
  final bool isNetwork;
  final double height;
  final double width;

  const VideoItem({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    this.isNetwork = true,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    if (widget.isNetwork) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.url ?? ""));
    } else {
      videoPlayerController =
          VideoPlayerController.file(File(widget.url ?? ""));
    }

    videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        hideControlsTimer: const Duration(seconds: 1),
        materialProgressColors: ChewieProgressColors(
          playedColor: CustomStyle.red,
          handleColor: CustomStyle.primary,
          backgroundColor: CustomStyle.bgDark,
          bufferedColor: CustomStyle.white,
        ),
        placeholder: Container(
          color: CustomStyle.bgDark,
        ),
        autoInitialize: true,
      );
      setState(() {});
    });
    _chewieController =
        ChewieController(videoPlayerController: videoPlayerController);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
          height: widget.height.r,
          width: widget.width.r,
          child: Center(child: Chewie(controller: _chewieController))),
    );
  }
}
