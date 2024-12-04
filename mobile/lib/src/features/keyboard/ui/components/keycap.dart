import 'package:controller/src/features/keyboard/bloc/keyboard_actions.dart';
import 'package:controller/src/socket/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicKeyboardKeyComponent extends StatefulWidget {
  const BasicKeyboardKeyComponent({
    super.key,
    this.size = 80,
    required this.text,
  }) : assert(text.length == 1);

  final String text;

  /// Key size
  final double size;

  @override
  State<BasicKeyboardKeyComponent> createState() =>
      _BasicKeyboardKeyComponentState();
}

class _BasicKeyboardKeyComponentState extends State<BasicKeyboardKeyComponent>
    with KeyboardButton, KeyboardButtonHoldAndRelease {
      @override
  void initState() {
    keyboard = KeyboardControl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
        press(widget.text);
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        release(widget.text);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/components/path1.svg',
            width: widget.size,
            height: widget.size,
            colorFilter: ColorFilter.mode(
              isPressed ? Colors.black54 : Colors.black,
              BlendMode.srcIn,
            ),
          ),
          Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
