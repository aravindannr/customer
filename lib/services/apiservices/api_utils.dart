import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:teresa_customer/modal/designer_modal.dart';
import 'package:teresa_customer/modal/message_modal.dart';
import 'package:teresa_customer/modal/user_modal.dart';

class ApiUtils {
  // late CustomerModal me;
  CustomerModal getCurrentUserData(
      DocumentSnapshot<Map<String, dynamic>> customerDocumentSnapshot) {
    try {
      CustomerModal customerModal =
          CustomerModal.fromJson(customerDocumentSnapshot.data()!);
      // me = customerModal;
      return customerModal;
    } catch (e) {
      if (kDebugMode) {
        print("**** getCurrentUserData: Error on util class :$e ****");
      }
      rethrow;
    }
  }

  Future<DesignerModal> fnGetDesignerData(
      DocumentSnapshot<Map<String, dynamic>> desingerDocumentSnapshot) async {
    try {
      DesignerModal designerModal =
          DesignerModal.fromJson(desingerDocumentSnapshot.data()!);
      return designerModal;
    } catch (e) {
      if (kDebugMode) {
        print("**** fnGetDesignerData: Error on  util class:$e ****");
      }
      rethrow;
    }
  }

  List<MessageModal> getAllMessages(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) {
    try {
      List<MessageModal> messages =
          data.map((e) => MessageModal.fromJson(e.data())).toList();
      return messages;
    } catch (e) {
      if (kDebugMode) {
        print("**** getAllMessages :Error on  util class:$e ****");
      }
      rethrow;
    }
  }
}
