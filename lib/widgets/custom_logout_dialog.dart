import 'package:flutter/material.dart';
import '../screen/sign_in/credential_sign_in.dart';

class LogoutAlert extends StatefulWidget {
  const LogoutAlert({super.key});

  @override
  State<LogoutAlert> createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text(
        'Logout?',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      content: const Text(
        'Are you sure you want to Logout?',
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CredentialSignIn(),
              ),
                  (route) => false,
            );
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
