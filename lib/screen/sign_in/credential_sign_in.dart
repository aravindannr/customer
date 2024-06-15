import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../services/apiservices/api_services.dart';
import '../../utils/custom_bottom_bar.dart';
import '../../utils/custom_logo_spinner.dart';
import '../../widgets/custom_error_dialog.dart';

class CredentialSignIn extends StatefulWidget {
  const CredentialSignIn({super.key});

  @override
  State<CredentialSignIn> createState() => _CredentialSignInState();
}

class _CredentialSignInState extends State<CredentialSignIn> {
  final TextEditingController _emailSignInController = TextEditingController();
  final TextEditingController _emailSignUpController = TextEditingController();
  final TextEditingController _passwordSignInController =
      TextEditingController();
  final TextEditingController _passwordSignUpController =
      TextEditingController();
  final _eMailSignInKey = GlobalKey<FormState>();
  final _eMailSignUpKey = GlobalKey<FormState>();
  final _passwordSignInKey = GlobalKey<FormState>();
  final _passwordSignUpKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  bool _isPageLoading = true;
  ApiServices services = ApiServices();

  @override
  void dispose() {
    _emailSignInController.dispose();
    _passwordSignInController.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool _isRememberMe = true;
  bool _isVisibility = false;
  bool _isSignInButtonLoading = false;
  bool _isSignUpButtonLoading = false;

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _fnLoadingDelay();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://videos.pexels.com/video-files/8776998/8776998-sd_540_960_25fps.mp4',
      ),
    )..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
          _controller.setVolume(0.0);
        });
      });
  }

  _fnLoadingDelay() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isPageLoading = false;
      });
    });
  }

  _fnNavigateToHomePage() async {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const CustomBottomBar(),
        settings: const RouteSettings(name: '/home'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _isPageLoading
            ? const CustomLogoSpinner(
                oneSize: 10,
                roundSize: 30,
                color: Colors.white,
              )
            : Stack(
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned(
                    top: height * 0.1,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/teresa_logo_white.png',
                      height: height * 0.25,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Colors.transparent,
                          //     Colors.white54,
                          //     Colors.white,
                          //     Colors.white,
                          //   ],
                          // ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        height: 450,
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Form(
                                    key: _eMailSignInKey,
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a valid email';
                                        } else if (!value.contains('@') &&
                                            value.contains('.') &&
                                            value.length < 5) {
                                          return 'Please enter valid email';
                                        }
                                        return null;
                                      },
                                      controller: _emailSignInController,
                                      decoration: const InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Form(
                                    key: _passwordSignInKey,
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      controller: _passwordSignInController,
                                      obscureText: !_isVisibility,
                                      decoration: InputDecoration(
                                        errorStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          size: 20,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isVisibility = !_isVisibility;
                                            });
                                          },
                                          child: Icon(
                                            _isVisibility
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        value: _isRememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            _isRememberMe = value!;
                                          });
                                        },
                                        activeColor: Colors.black,
                                        checkColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(
                                          width: 2,
                                        ),
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Forgot Password',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: _isSignInButtonLoading
                                        ? const CustomLogoSpinner(
                                            oneSize: 10,
                                            roundSize: 30,
                                            color: Colors.black,
                                          )
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                            ),
                                            onPressed: () async {
                                              if (!_eMailSignInKey.currentState!
                                                      .validate() ||
                                                  !_passwordSignInKey
                                                      .currentState!
                                                      .validate()) {
                                                return;
                                              }
                                              fnLogin(
                                                "aravind@gmail.com",
                                                "aravind",
                                              );
                                            },
                                            child: const Text(
                                              'LOGIN',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Don\'t have an account ?',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _pageController.animateToPage(
                                            1,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    endIndent: 40,
                                    indent: 40,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/apple_black.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Image.asset(
                                          "assets/icons/google_black.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Form(
                                    key: _eMailSignUpKey,
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a valid email';
                                        } else if (!value.contains('@') &&
                                            value.contains('.') &&
                                            value.length < 5) {
                                          return 'Please enter valid email';
                                        }
                                        return null;
                                      },
                                      controller: _emailSignUpController,
                                      decoration: const InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: 'Email',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Form(
                                    key: _passwordSignUpKey,
                                    child: TextFormField(
                                      cursorColor: Colors.grey,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      controller: _passwordSignUpController,
                                      obscureText: !_isVisibility,
                                      decoration: InputDecoration(
                                        errorStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        hintText: 'Password',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          size: 20,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isVisibility = !_isVisibility;
                                            });
                                          },
                                          child: Icon(
                                            _isVisibility
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        value: _isRememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            _isRememberMe = value!;
                                          });
                                        },
                                        activeColor: Colors.black,
                                        checkColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(
                                          width: 2,
                                        ),
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: _isSignUpButtonLoading
                                        ? const CustomLogoSpinner(
                                            oneSize: 10,
                                            roundSize: 30,
                                            color: Colors.black,
                                          )
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                            ),
                                            onPressed: () async {
                                              if (!_eMailSignUpKey.currentState!
                                                      .validate() ||
                                                  !_passwordSignUpKey
                                                      .currentState!
                                                      .validate()) {
                                                return;
                                              }
                                              // await Future.delayed(
                                              //   const Duration(seconds: 2),
                                              //   () {
                                              //     _fnNavigateToHomePage();
                                              //   },
                                              // );
                                              // fnLogin(
                                              //   "aravind@gmail.com",
                                              //   "aravind",
                                              // );
                                            },
                                            child: const Text(
                                              'REGISTER',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Already have an account ?',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _pageController.animateToPage(
                                            0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    endIndent: 40,
                                    indent: 40,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/apple_black.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Image.asset(
                                          "assets/icons/google_black.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  fnLogin(String email, String password) async {
    try {
      setState(() {
        _isSignInButtonLoading = true;
      });
      UserCredential userCredential =
          await services.fnLoginWithEmailAndPassword(
        email,
        password,
      );
      if (userCredential.user == null) {
        throw ("User not found");
      }
      DocumentSnapshot<Object?> customer =
          await services.fnFetchCustomerFromUserCollection(
        userCredential.user!,
      );
      if (customer.exists) {
        _fnNavigateToHomePage();
      } else {
        throw ("Customer not found");
      }
      setState(() {
        _isSignInButtonLoading = false;
      });
    } catch (e) {
      setState(() {
        _isSignInButtonLoading = false;
      });
      if (!mounted) return;
      showDialog(
        barrierColor: Colors.black.withOpacity(0.8),
        context: context,
        builder: (context) => CustomErrorDialog(
          content: e.toString(),
        ),
      );
      if (kDebugMode) {
        print("fnLogin Exception on loginPage: $e");
      }
    }
  }
}
