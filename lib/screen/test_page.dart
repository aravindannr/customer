import 'package:flutter/material.dart';

class Testpage1 extends StatefulWidget {
  const Testpage1({super.key});

  @override
  State<Testpage1> createState() => _TestpageState();
}

class _TestpageState extends State<Testpage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/icons/work-in-progress.png',
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }
}
