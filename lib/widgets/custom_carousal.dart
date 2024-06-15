import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teresa_customer/modal/message_modal.dart';
import 'package:teresa_customer/services/apiservices/api_services.dart';

class CustomCarousel extends StatefulWidget {
  final MessageModal message;
  const CustomCarousel({super.key, required this.message});
  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.message.customWidgets.confirmationType,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: .4,
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: false,
          ),
          items: widget.message.customWidgets.imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    clipBehavior: Clip.antiAlias,
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        fit: BoxFit.cover,
                                        imageUrl: url),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      imageUrl: url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.message.customWidgets.bodyText[0].toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w300, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100],
                  foregroundColor: Colors.black),
              onPressed: widget.message.customWidgets.confirmationStatus == 1 ||
                      widget.message.customWidgets.confirmationStatus == 2
                  ? () {}
                  : () {
                      fnShowConfirmation("reject", () {
                        ApiServices()
                            .updateConfirmationStatus(2, widget.message);
                      });
                    },
              child: const Text("Reject"),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.black),
              onPressed: widget.message.customWidgets.confirmationStatus == 1 ||
                      widget.message.customWidgets.confirmationStatus == 2
                  ? () {}
                  : () {
                      fnShowConfirmation("accept", () {
                        ApiServices()
                            .updateConfirmationStatus(1, widget.message);
                      });
                    },
              child: const Text("Accept"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  fnShowConfirmation(String action, Function onPressed) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Do you want to $action this confirmation")],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("NO"),
                ),
                ElevatedButton(
                  onPressed: () {
                    onPressed();
                    Navigator.pop(context);
                  },
                  child: const Text("YES"),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
