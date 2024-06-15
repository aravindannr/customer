import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:teresa_customer/modal/designer_modal.dart';
import 'package:teresa_customer/modal/message_modal.dart';
import 'package:teresa_customer/modal/user_modal.dart';

class ApiServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  User get user => auth.currentUser!;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<UserCredential> fnLoginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        print(
            "**** fnLoginWithEmailAndPassword: Exception on service class :$e ****");
      }
      rethrow;
    }
  }

  Future<DocumentSnapshot<Object?>> fnFetchCustomerFromUserCollection(
    User user,
  ) async {
    try {
      CollectionReference customers = fireStore.collection("TblUser");
      var customer = await customers.doc("2").get();
      return customer;
    } catch (e) {
      if (kDebugMode) {
        print(
            "**** fnAddCustomerToUserCollection :Exception on service class : $e ****");
      }
      rethrow;
    }
  }

  //for fetching  current customer data
  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserData() async {
    try {
      // log(currentDesigner.uid);
      final customerDoc = await fireStore.collection('TblUser').doc("2").get();

      if (customerDoc.exists) {
        return customerDoc;
      } else {
        throw ("*****Customer document not found*****");
      }
    } catch (e) {
      if (kDebugMode) {
        print("***** getCurrentUserData :Error on service class:$e *****");
      }
      rethrow;
    }
  }

  //for fetching  Assigned designer data
  Future<DocumentSnapshot<Map<String, dynamic>>> fnGetDesignerData(
      String designerId) async {
    try {
      // log(currentDesigner.uid);
      final designerDoc =
          await fireStore.collection('TblDesigners').doc(designerId).get();

      if (designerDoc.exists) {
        return designerDoc;
      } else {
        throw ("*****Designer document not found*****");
      }
    } catch (e) {
      if (kDebugMode) {
        print("***** fnGetDesignerData : Error on   service class:$e *****");
      }
      rethrow;
    }
  }

  String getConversationId(String desingernId, String customerId) =>
      customerId.hashCode <= desingernId.hashCode
          ? '${customerId}_$desingernId'
          : '${desingernId}_${customerId}';

  Future<void> sendMessage(DesignerModal designer, String msg, MessageType type,
      CustomerModal me) async {
    try {
      final time = DateTime.now().millisecondsSinceEpoch.toString();
      final MessageModal message = MessageModal(
          customWidgets: CustomWidgets(
              imageUrls: [],
              bodyText: [],
              audioUrls: [],
              confirmationStatus: 0,
              confirmationType: ""),
          toId: designer.nId.toString(),
          dlvryTime: time,
          frId: me.nId.toString(),
          message: msg,
          type: type,
          sent: time,
          read: '');
      final ref = fireStore.collection(
          'TblChats/${getConversationId(designer.nId.toString(), me.nId.toString())}/messages/');
      ref.doc(time).set(message.toJson());
    } catch (e) {
      if (kDebugMode) {
        print("**** sendMessage:Error on service class : $e ****");
      }
      rethrow;
    }
  }

  //for fetching all messages
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      DesignerModal desinger, CustomerModal me) {
    return fireStore
        .collection(
            'TblChats/${getConversationId(desinger.nId.toString(), me.nId.toString())}/messages/')
        .orderBy('dlvryTime', descending: true)
        .snapshots();
  }

  // Future<void> sendImage(
  //     DesignerModal designerModal, File file, CustomerModal me) async {
  //   try {
  //     final ext = file.path.split('.').last;
  //     final ref = storage.ref().child(
  //         "image/${getConversationId(designerModal.nId.toString(), me.nId.toString())}/${designerModal.nId}/${DateTime.now().millisecondsSinceEpoch}.$ext");
  //     await ref
  //         .putFile(
  //       file,
  //       SettableMetadata(contentType: "image/$ext"),
  //     )
  //         .then((p0) {
  //       log("Data transfered: ${p0.bytesTransferred / 1000} kb");
  //     });
  //     final imageUrl = await ref.getDownloadURL();
  //     await sendMessage(designerModal, imageUrl, MessageType.image, me);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("****sendImage :error on service page : $e ****");
  //     }
  //   }
  // }

  // Future<void> sendVideo(
  //     CustomerModal customer, File file, DesignerModal designer) async {
  //   try {
  //     final ext = file.path.split('.').last;
  //     final ref = storage.ref().child(
  //         "video/${getConversationId(designer.uId, customer.uId)}/${DateTime.now().millisecondsSinceEpoch}.$ext");
  //     await ref
  //         .putFile(file, SettableMetadata(contentType: "video/$ext"))
  //         .then((onValue) {
  //       log("Data transferred: ${onValue.bytesTransferred / 1000} kb");
  //     });
  //     final videoUrl = await ref.getDownloadURL();
  //     await sendMessage(designer, videoUrl, MessageType.video, customer);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('sendVideo:Getting exception on service page: $e');
  //     }
  //     rethrow;
  //   }
  // }

  Future<void> updateMessageReadStatus(MessageModal message) async {
    try {
      fireStore
          .collection(
              'TblChats/${getConversationId(message.toId, message.frId)}/messages/')
          .doc(message.sent)
          .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
    } catch (e) {
      if (kDebugMode) {
        print(
            "Exception caught on Firebase services updateMessageReadStatus :$e ");
      }
      rethrow;
    }
  }

  // Future<void> updateMessage(
  //     MessageModal messageModal, String updateMessage) async {
  //   await fireStore
  //       .collection(
  //           'TblChats/${getConversationId(messageModal.toId, messageModal.frId)}/messages/')
  //       .doc(messageModal.dlvryTime)
  //       .update({"message": updateMessage});
  // }

  Future<void> deleteMessage(MessageModal messageModal) async {
    try {
      fireStore
          .collection(
              'TblChats/${getConversationId(messageModal.toId, messageModal.frId)}/messages/')
          .doc(messageModal.sent)
          .delete();
      //for deleting images from the storage
      if (messageModal.type == MessageType.image) {
        await storage.refFromURL(messageModal.message).delete();
      }
    } catch (e) {
      if (kDebugMode) {
        print(
            "**** Exception caught on Firebase services updateMessageReadStatus :$e ****");
      }
      if (e is FirebaseException) {
        if (kDebugMode) {
          print('FirebaseException code: ${e.code}');
        }
        if (kDebugMode) {
          print('FirebaseException message: ${e.message}');
        }
      }
      rethrow;
    }
  }

  Future<void> updateConfirmationStatus(
      int status, MessageModal message) async {
    try {
      final ref = fireStore.collection(
          'TblChats/${getConversationId(message.frId, message.toId)}/messages/');
      await ref.doc(message.sent).update({
        "customWidgets.confirmationStatus": status,
      });
    } catch (e) {
      if (kDebugMode) {
        print("**** updateConfirmationStatus: Error updating status : $e ****");
      }
    }
  }

  Future<void> sendMedia(
      DesignerModal designer, File file, CustomerModal customer) async {
    try {
      final ext = file.path.split('.').last;
      String contentType;

      // Determine the content type based on file extension
      switch (ext.toLowerCase()) {
        case 'jpg':
        case 'jpeg':
        case 'png':
          contentType = 'image/$ext';
          break;
        case 'mp4':
        case 'mov':
          contentType = 'video/$ext';
          break;
        case 'pdf':
          contentType = 'application/pdf';
          break;
        default:
          contentType = 'application/octet-stream';
          break;
      }

      final conversationId =
          getConversationId(customer.nId.toString(), designer.nId.toString());
      final ref = storage.ref().child(
          "media/$conversationId/${customer.nId}/${DateTime.now().millisecondsSinceEpoch}.$ext");

      final uploadTask = await ref.putFile(
        file,
        SettableMetadata(contentType: contentType),
      );

      log("Data transferred: ${uploadTask.bytesTransferred / 1000} kb");

      final mediaUrl = await ref.getDownloadURL();

      // Determine the message type based on content type
      MessageType messageType;
      if (contentType.startsWith('image/')) {
        messageType = MessageType.image;
      } else if (contentType.startsWith('video/')) {
        messageType = MessageType.video;
      } else {
        messageType = MessageType.text;
      }

      await sendMessage(designer, mediaUrl, messageType, customer);
    } catch (e) {
      if (kDebugMode) {
        print("Exception caught on Firebase services sendMedia: $e");
      }
      rethrow;
    }
  }
}
