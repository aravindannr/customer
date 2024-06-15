import 'package:flutter/material.dart';
import '../sign_in/credential_sign_in.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ChangePasswordPage> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Change Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'userImage',
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/user.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Samuel L Jackson',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'UID1232',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextField(
                heading: 'Current Password',
              ),
              const CustomTextField(
                heading: 'New Password',
              ),
              const CustomTextField(
                heading: 'Confirm Password',
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CredentialSignIn(),
                          ),
                        );
                      },
                      child: const Text('Reset Password'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.heading,
  });

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  $heading',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 2,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
