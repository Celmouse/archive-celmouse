import 'package:controller/src/UI/trackpad/view/trackpad.dart';
import 'package:flutter/material.dart';

class TrackpadPage extends StatelessWidget {
  const TrackpadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'mouse-mode-switch',
        child: TrackPad(
          onDragUpdate: (details) {
            // Handle drag update
            print('Drag update: ${details.delta.dx}, ${details.delta.dy}');
          },
          onTwoFingerTap: () {
            // Handle two finger tap
            print('Two finger tap');
          },
          onTap: () {
            // Handle tap
            print('Tap');
          },
          onDoubleTap: () {
            // Handle double tap
            print('Double tap');
          },
          baseColor: Colors.grey[200]!,
        ),
      ),
    );
  }
}
