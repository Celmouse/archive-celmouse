import 'package:flutter/material.dart';

class TrackPadRepository {
  void handleDrag(DragUpdateDetails details) {
    // Implement the logic for handling drag updates
    print('Drag update: ${details.delta}');
  }

  void handleTap() {
    // Implement the logic for handling single tap
    print('Single tap');
  }

  void handleDoubleTap() {
    // Implement the logic for handling double tap
    print('Double tap');
  }

  void handleTwoFingerTap() {
    // Implement the logic for handling two-finger tap
    print('Two-finger tap');
  }
}
