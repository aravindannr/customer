import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAlert extends StatefulWidget {
  const ExitAlert({super.key});

  @override
  State<ExitAlert> createState() => _ExitAlertState();
}

class _ExitAlertState extends State<ExitAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Exit?', style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      content: const Text(
        'Are you sure you want to exit the app?',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'No',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context);
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
