import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final bool concave;
  final bool isButton;
  final bool isDark;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double height;
  final double width;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.borderRadius = 40,
    this.concave = false,
    this.isButton = false,
    this.isDark = true,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.height = 560,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF0F0F0);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Top left shadow (light)
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.5)
                : Colors.white.withOpacity(0.5),
            offset: const Offset(-4, -4),
            blurRadius: 10,
            spreadRadius: concave ? 1 : 0,
          ),
          // Bottom right shadow (dark)
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.7)
                : Colors.grey[300]!.withOpacity(0.7),
            offset: const Offset(4, 4),
            blurRadius: 10,
            spreadRadius: concave ? 1 : 0,
          ),
        ],
        gradient: isButton
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark ? Colors.grey[850]! : Colors.white,
                  isDark ? Colors.grey[900]! : Colors.grey[100]!,
                ],
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
