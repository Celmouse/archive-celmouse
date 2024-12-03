import 'package:controller/src/features/mouse/move/bloc/mouse_actions.dart';
import 'package:controller/src/features/mouse/socket_mouse.dart';
import 'package:flutter/material.dart';
import 'package:protocol/protocol.dart';

class RightMouseButton extends StatefulWidget {
  const RightMouseButton({
    super.key,
    required this.mouse,
  });

  final MouseControl mouse;

  @override
  State<RightMouseButton> createState() => _RightMouseButtonState();
}

class _RightMouseButtonState extends State<RightMouseButton>
    with MouseButton, ButtonClick {
  @override
  void initState() {
    mouse = widget.mouse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        click(ClickType.right);
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: isPressed ? Colors.blue[200] : Colors.blue,
        ),
        height: size.height * 0.3,
        width: size.width / 2 - 20,
      ),
    );
  }
}
