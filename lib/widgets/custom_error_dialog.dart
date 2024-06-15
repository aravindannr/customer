import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  final String content;

  const CustomErrorDialog({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "Assets/images/warning.png",
              height: 80,
              width: 80,
            ),

            const Text(
              "Oops!",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.grey,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
