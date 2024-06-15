import 'package:flutter/material.dart';

import 'credential_sign_in.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  String? userName;
  String? passWord;
  String? prmCmpId;
  String? prmBrId;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fnPushToLogin();
    _fnCheckIfSignedIn();
  }

  void _fnCheckIfSignedIn() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CredentialSignIn(),
        settings: const RouteSettings(name: '/credentialSignIn'),
      ),
    );
  }

  _fnPushToLogin() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _isLoading
            ? const SizedBox()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/teresa_logo_white.png',
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
      ),
    );
  }
}
