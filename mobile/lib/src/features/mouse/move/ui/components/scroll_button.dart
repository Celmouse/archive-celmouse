import 'package:controller/src/features/mouse/move/bloc/mouse_movement.dart';
import 'package:flutter/material.dart';

class ScrollMouseButton extends StatefulWidget {
  const ScrollMouseButton({
    super.key,
    required this.movement,
  });

  final MouseMovement movement;

  @override
  State<ScrollMouseButton> createState() => _ScrollMouseButtonState();
}

class _ScrollMouseButtonState extends State<ScrollMouseButton> {
  bool isActive = false;

  enableScrolling() {
    setState(() {
      isActive = true;
    });

    widget.movement.pauseMouseMovement();
    widget.movement.startScrollMovement();
  }

  bool tmpCursorMovingEnabled = false;

  disableScrolling() {
    setState(() {
      isActive = false;
    });

    widget.movement.stopScrollMovement();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTapDown: (_) => enableScrolling(),
      onTapUp: (_) => disableScrolling(),
      child: Container(
        width: double.infinity,
        height: size.height * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isActive ? Colors.purple[200] : Colors.purple,
        ),
      ),
    );
  }
}
