import 'package:controller/src/features/mouse/move/bloc/mouse_actions.dart';
import 'package:controller/src/features/mouse/socket_mouse.dart';
import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

class ShotButtonComponent extends StatefulWidget {
  const ShotButtonComponent({super.key});

  @override
  State<ShotButtonComponent> createState() => _ShotButtonComponentState();
}

class _ShotButtonComponentState extends State<ShotButtonComponent>
    with MouseButton, ButtonHoldAndRelease, ButtonClick {
  @override
  void initState() {
    mouse = MouseControl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        click(ClickType.left);
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        height: 140,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPressed ? Colors.red[200] : Colors.red,
        ),
      ),
    );
  }
}
