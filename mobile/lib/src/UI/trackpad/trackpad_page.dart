import 'package:controller/src/UI/trackpad/view/trackpad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrackpadPage extends StatefulWidget {
  const TrackpadPage({super.key});

  @override
  State<TrackpadPage> createState() => _TrackpadPageState();
}

class _TrackpadPageState extends State<TrackpadPage> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TrackPad(
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
    );
  }
}
