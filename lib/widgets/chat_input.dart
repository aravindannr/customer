import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teresa_customer/modal/designer_modal.dart';
import 'package:teresa_customer/modal/message_modal.dart';
import 'package:teresa_customer/modal/user_modal.dart';
import 'package:teresa_customer/services/apiservices/api_services.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.designerModal,
    required this.customer,
    required this.onPlusClicked,
  });
  final DesignerModal designerModal;
  final CustomerModal customer;
  final VoidCallback onPlusClicked;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController messageController = TextEditingController();
  bool isRecording = false;
  String message = '';
  Future<void> _pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        ApiServices()
            .sendMedia(widget.designerModal, File(image.path), widget.customer);
      }
      if (kDebugMode) {
        print('Image path: ${image!.path}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('_pickImage : error on chat input :$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget.onPlusClicked();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: height * .09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextFormField(
                controller: messageController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                maxLines: 2,
                minLines: 1,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  hintText: "Type your message...",
                  filled: true,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    message = value.trim();
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _pickImage();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Center(
                child: message.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          message = message.replaceAll(RegExp(r'\s+'), ' ');
                          ApiServices().sendMessage(
                            widget.designerModal,
                            message,
                            MessageType.text,
                            widget.customer,
                          );
                          messageController.clear();
                          setState(() {
                            message = '';
                          });
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.white,
                      )
                    : isRecording == true
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                isRecording = false;
                              });
                            },
                            icon: const Icon(Icons.stop),
                            color: Colors.white,
                          )
                        : IconButton(
                            onPressed: () {
                              if (messageController.text.isEmpty) {
                                setState(() {
                                  isRecording = true;
                                });
                              }
                            },
                            icon: const Icon(Icons.mic),
                            color: Colors.white,
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
