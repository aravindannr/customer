import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teresa_customer/modal/designer_modal.dart';
import 'package:teresa_customer/modal/message_modal.dart';
import 'package:teresa_customer/modal/user_modal.dart';
import 'package:teresa_customer/services/apiservices/api_utils.dart';
import 'package:teresa_customer/services/apiservices/api_services.dart';
import 'package:teresa_customer/utils/bottom_options.dart';
import 'package:teresa_customer/utils/custom_alert.dart';
import 'package:teresa_customer/utils/custom_logo_spinner.dart';
import 'package:teresa_customer/widgets/chat_input.dart';
import 'package:teresa_customer/widgets/message_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.customer,
  });
  final CustomerModal customer;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<MessageModal> messages = [];
  bool isLoading = true;
  late DesignerModal designerModal;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    fnGetDesignerData();
  }

  Stream<List<MessageModal>> getAllMessages() {
    try {
      return ApiServices()
          .getAllMessages(designerModal, widget.customer)
          .map((snapshot) {
        final data = snapshot.docs;
        messages = ApiUtils().getAllMessages(data);
        return messages;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Exception on getAllmessages  $e");
      }
      setState(() {
        isLoading = false;
      });
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(.8),
        context: context,
        builder: (BuildContext context) => CustomErrorAlert(
          content: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> pickMedia(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.media,
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          setState(() {
            isSending = true;
          });
          await ApiServices()
              .sendMedia(
            designerModal,
            File(file.path!),
            widget.customer,
          )
              .whenComplete(() {
            setState(() {
              isSending = false;
            });
            Navigator.pop(context);
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("**** pickMedia:Getting error on chat page :$e ");
      }
    }
  }

  fnGetDesignerData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> customerDoc = await ApiServices()
          .fnGetDesignerData(widget.customer.assignedDesigner[0]);
      designerModal = await ApiUtils().fnGetDesignerData(customerDoc).then(
        (value) {
          setState(() {
            isLoading = false;
          });
          return value;
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Exception on fetchDesignerData $e");
      }
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(.8),
        context: context,
        builder: (BuildContext context) => CustomErrorAlert(
          content: e.toString(),
        ),
      );
    }
  }

//show dialogue function when + button clicked
  void showBottomOptionsDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buildBottomOptionsRow(
                [
                  Icons.image,
                  Icons.camera_alt,
                  Icons.note_add_outlined,
                ],
                [
                  () {
                    pickMedia(context);
                    Navigator.pop(context);
                  },
                  () {
                    Navigator.pop(context);
                  },
                  () {
                    Navigator.pop(context);
                  },
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buildBottomOptionsRow(
                [
                  Icons.headphones,
                  Icons.location_on_outlined,
                  null,
                ],
                [
                  () {
                    Navigator.pop(context);
                  },
                  () {
                    Navigator.pop(context);
                  },
                  null,
                ],
              ),
            ),
          ],
        );
      },
    );
  }

//for generating bottom sheet items
  List<Widget> buildBottomOptionsRow(
      List<IconData?> icons, List<VoidCallback?> actions) {
    return List.generate(icons.length, (index) {
      final icon = icons[index];
      final action = actions[index];

      if (icon == null || action == null) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            width: 60,
          ),
        );
      } else {
        return BottomOptions(
          optionIcon: icon,
          onOptionPressed: action,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CustomLogoSpinner(),
      );
    }
    // Future<void> _makeCall(String phoneNumer) async {
    //   try {
    //     final Uri lanchUri = Uri(scheme: 'tel', path: phoneNumer);
    //     await launchUrl(lanchUri);
    //   } catch (e) {
    //     if (kDebugMode) {
    //       print("****_makeCall : error on chatPage :$e **** ");
    //     }
    //   }
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                designerModal.cName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              Text(
                " (Fashion Consultant)",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       _makeCall("9060412989");
          //     },
          //     icon: Icon(
          //       Icons.call_outlined,
          //       color: Theme.of(context).colorScheme.surface,
          //     ),
          //   ),
          // ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ApiServices()
                    .getAllMessages(designerModal, widget.customer),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                    case ConnectionState.active:
                      messages = data
                              ?.map((e) => MessageModal.fromJson(e.data()))
                              .toList() ??
                          [];
                      if (messages.isNotEmpty) {
                        return ListView.builder(
                            itemCount: messages.length,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return MessageCard(
                                message: messages[index],
                                me: widget.customer,
                              );
                            });
                      } else {
                        return const Center(
                          child: Text(
                            "Say Hi...",
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            //for showing progress bar when image or video uploading
            if (isSending)
              const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 5,
                    ),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )),
            ChatInput(
              designerModal: designerModal,
              customer: widget.customer,
              onPlusClicked: showBottomOptionsDialog,
            )
          ],
        ),
      ),
    );
  }
}
