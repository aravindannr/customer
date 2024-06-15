import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:teresa_customer/modal/message_modal.dart';
import 'package:teresa_customer/modal/user_modal.dart';
import 'package:teresa_customer/services/apiservices/api_services.dart';
import 'package:teresa_customer/utils/custom_logo_spinner.dart';
import 'package:teresa_customer/utils/custom_snackbar.dart';
import 'package:teresa_customer/utils/date_util.dart';
import 'package:teresa_customer/widgets/custom_carousal.dart';
import 'package:teresa_customer/widgets/video_player_page.dart';
import 'package:video_player/video_player.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({
    super.key,
    required this.message,
    required this.me,
  });
  final MessageModal message;
  final CustomerModal me;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  late bool isMe;
  bool isDeleting = false;
  late VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;

  void _initializeVideoPlayer(String videoUrl) {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoPlayerController?.play();
      }).catchError((error) {
        if (kDebugMode) {
          print("Error initializing video player: $error");
        }
      });
  }

  @override
  void initState() {
    super.initState();
    if (widget.message.type == MessageType.video) {
      _initializeVideoPlayer(widget.message.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onMessageLongPress() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            widget.message.type == MessageType.text ||
                    widget.message.type == MessageType.image
                ? isMe
                    ? ListTile(
                        leading: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        title: const Text("Delete Message"),
                        onTap: () {
                          Navigator.pop(context);
                          fnDeleteMessage();
                        },
                      )
                    : const SizedBox()
                : const SizedBox(),
            widget.message.type == MessageType.text
                ? ListTile(
                    leading: const Icon(
                      Icons.copy,
                    ),
                    title: const Text("Copy message"),
                    onTap: () async {
                      await Clipboard.setData(
                              ClipboardData(text: widget.message.message))
                          .then((value) {
                        Navigator.pop(context);
                        CustomSnackBar.showSnackBar(
                          context,
                          "Text copied",
                          Colors.white,
                        );
                      });
                    },
                  )
                : widget.message.type == MessageType.image
                    ? ListTile(
                        leading: const Icon(
                          Icons.download_for_offline_outlined,
                        ),
                        title: const Text("Download"),
                        onTap: () async {
                          try {
                            var response = await Dio().get(
                                widget.message.message,
                                options:
                                    Options(responseType: ResponseType.bytes));
                            final result = await ImageGallerySaver.saveImage(
                                Uint8List.fromList(response.data),
                                quality: 60,
                                name: "hello");
                            Navigator.pop(context);
                            CustomSnackBar.showSnackBar(
                                context, "Message copied", Colors.green);
                          } catch (e) {
                            if (kDebugMode) {
                              print(
                                  "Getting error on message card when download image $e");
                            }
                          }
                        },
                      )
                    : const SizedBox(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isMe = widget.me.nId.toString() == widget.message.frId;
    return InkWell(
        onLongPress: widget.message.type == MessageType.widget
            ? () {}
            : () {
                onMessageLongPress();
              },
        child: isMe ? customerMessageCard() : designerMessageCard());
  }

  Widget designerMessageCard() {
    if (widget.message.read.isEmpty) {
      ApiServices().updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 50,
              left: 5,
            ),
            padding: widget.message.type == MessageType.text
                ? const EdgeInsets.all(10)
                : const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: const Color(0xffEFF5F5),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
                topRight: const Radius.circular(30),
                bottomLeft: widget.message.type == MessageType.text
                    ? const Radius.circular(0)
                    : const Radius.circular(30),
              ),
              border: Border.all(
                color: widget.message.type == MessageType.text
                    ? Colors.blueGrey
                    : Colors.transparent,
              ),
            ),
            child: widget.message.type == MessageType.text
                ? Text(
                    widget.message.message,
                    style: const TextStyle(color: Colors.black),
                  )
                : widget.message.type == MessageType.widget
                    ? CustomCarousel(message: widget.message)
                    : widget.message.type == MessageType.video
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerPage(
                                    videoUrl: widget.message.message,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height:
                                      MediaQuery.of(context).size.height * 0.40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Container(
                                    color: Colors.black,
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_circle_fill,
                                        size: 64,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8,
                                  right: 12,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                        DateUtil().getFormattedtime(
                                            context: context,
                                            time: widget.message.dlvryTime),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              fnViewImage(widget.message.message);
                            },
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        0.40,
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    filterQuality: FilterQuality.high,
                                    imageUrl: widget.message.message,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.image,
                                      size: 70,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.4),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 12,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Text(
                                          DateUtil().getFormattedtime(
                                              context: context,
                                              time: widget.message.dlvryTime),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
          ),
        ),
      ],
    );
  }

  Widget customerMessageCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 50, right: 5),
                padding: widget.message.type == MessageType.text
                    ? const EdgeInsets.all(10)
                    : const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: const Color(0xffD6E4E5),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    bottomLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                    bottomRight: widget.message.type == MessageType.text
                        ? const Radius.circular(0)
                        : const Radius.circular(30),
                  ),
                  border: Border.all(
                    color: widget.message.type == MessageType.text
                        ? Colors.blueGrey
                        : Colors.transparent,
                  ),
                ),
                child: Column(
                  children: [
                    widget.message.type == MessageType.text
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.message.message,
                                style: const TextStyle(color: Colors.black),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateUtil().getFormattedtime(
                                        context: context,
                                        time: widget.message.dlvryTime),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.done_all,
                                    color: widget.message.read.isNotEmpty
                                        ? Colors.blue.shade300
                                        : Colors.grey,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ],
                          )
                        : widget.message.type == MessageType.widget
                            ? CustomCarousel(message: widget.message)
                            : widget.message.type == MessageType.video
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => VideoPlayerPage(
                                            videoUrl: widget.message.message,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: Container(
                                            color: Colors.black,
                                            child: const Center(
                                              child: Icon(
                                                Icons.play_circle_fill,
                                                size: 64,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 8,
                                          right: 12,
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              Text(
                                                DateUtil().getFormattedtime(
                                                    context: context,
                                                    time: widget
                                                        .message.dlvryTime),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Icon(
                                                Icons.done_all,
                                                color: widget
                                                        .message.read.isNotEmpty
                                                    ? Colors.blue.shade300
                                                    : Colors.grey,
                                                size: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      fnViewImage(widget.message.message);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            filterQuality: FilterQuality.high,
                                            imageUrl: widget.message.message,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.image,
                                              size: 70,
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.4),
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 8,
                                            right: 12,
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  DateUtil().getFormattedtime(
                                                      context: context,
                                                      time: widget
                                                          .message.dlvryTime),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Icon(
                                                  Icons.done_all,
                                                  color: widget.message.read
                                                          .isNotEmpty
                                                      ? Colors.blue.shade300
                                                      : Colors.grey,
                                                  size: 18,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  fnViewImage(String imageUrl) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  fnDeleteMessage() {
    showDialog(
      context: context,
      builder: (context) => isDeleting
          ? const CustomLogoSpinner()
          : AlertDialog(
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "Do you want to delete this message?",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () async {
                    isDeleting = true;
                    await ApiServices()
                        .deleteMessage(widget.message)
                        .then((value) {
                      Navigator.pop(context);
                      isDeleting = false;
                      CustomSnackBar.showSnackBar(
                        context,
                        "Deleted successfully",
                        Colors.red,
                      );
                    });
                  },
                  child: const Text("Yes"),
                )
              ],
            ),
    );
  }
}
