import 'package:flutter/material.dart';

class BottomOptions extends StatelessWidget {
  const BottomOptions({
    super.key,
    required this.optionIcon,
    required this.onOptionPressed,
  });
  final IconData optionIcon;
  final VoidCallback onOptionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onOptionPressed,
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white70,
          ),
          child: Icon(
            optionIcon,
            size: 35,
            color: const Color(0xff686D76),
          ),
        ),
      ),
    );
  }
}
