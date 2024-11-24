import 'package:flutter/material.dart';

import '../../bloc/mouse_movement.dart';

class MoveMouseButton extends StatefulWidget {
  const MoveMouseButton({
    super.key,
    required this.movement,
  });

  final MouseMovement movement;

  @override
  State<MoveMouseButton> createState() => _MoveMouseButtonState();
}

class _MoveMouseButtonState extends State<MoveMouseButton> {
  bool isActive = false;

  void disableMouseMovement() {
    setState(() {
      isActive = false;
    });

    widget.movement.stopMouseMovement();
  }

  /// Enable the mouse movement and center the cursor
  void enableMouseMovement() {
    setState(() {
      isActive = true;
    });

    // mouse.center();
    widget.movement.startMouseMovement();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: isActive ? disableMouseMovement : enableMouseMovement,
      child: Container(
        width: double.infinity,
        height: size.height * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isActive ? Colors.green[200] : Colors.green,
        ),
      ),
    );
  }
}
