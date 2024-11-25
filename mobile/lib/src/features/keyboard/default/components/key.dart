import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class KeyboardKeyComponent extends StatefulWidget {
  const KeyboardKeyComponent({
    super.key,
    required this.value,
    required this.height,
    required this.width,
  });
  final String value;
  final double height;
  final double width;

  @override
  State<KeyboardKeyComponent> createState() => _KeyboardKeyComponentState();
}

class _KeyboardKeyComponentState extends State<KeyboardKeyComponent> {
  final player = AudioPlayer();
  bool isActive = false;

  @override
  void initState() {
    player
        .setAsset('assets/sounds/keycap_blue_switch.wav', preload: true)
        .then(print);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isActive = true;
        });
        player.play();
      },
      onTapUp: (_) {
        setState(() {
          isActive = false;
        });
        player.stop();
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: !isActive ? Colors.blue : Colors.blue[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.value,
          ),
        ),
      ),
    );
  }
}
