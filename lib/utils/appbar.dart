import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.leading,
    required this.trailing,
  });

  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Expanded(child: leading),
          Expanded(flex : 5,child: trailing),
        ],
      ),
    );
  }
}
