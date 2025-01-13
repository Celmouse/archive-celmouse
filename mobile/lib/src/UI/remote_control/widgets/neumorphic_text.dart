import 'package:flutter/material.dart';

class NeumorphicText extends StatelessWidget {
  final String text;
  final bool isDark;

  const NeumorphicText(
    this.text, {
    super.key,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        foreground: Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 1
          ..color = isDark ? Colors.white54 : Colors.black54,
      ),
    );
  }
}
