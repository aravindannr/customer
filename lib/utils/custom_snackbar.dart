import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(
      BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // static void showProgressBar(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }
}
