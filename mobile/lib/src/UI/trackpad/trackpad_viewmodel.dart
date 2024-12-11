import 'package:flutter/material.dart';

class TrackPadViewModel extends ChangeNotifier {
  bool _isDragging = false;
  bool _isTapped = false;
  bool _isDoubleTapped = false;
  bool _isTwoFingerTapped = false;
  double _mouseX = 200; // Initial center position
  double _mouseY = 200; // Initial center position

  bool get isDragging => _isDragging;
  bool get isTapped => _isTapped;
  bool get isDoubleTapped => _isDoubleTapped;
  bool get isTwoFingerTapped => _isTwoFingerTapped;
  double get mouseX => _mouseX;
  double get mouseY => _mouseY;

  Color get backgroundColor {
    if (_isDragging) return Colors.green[100]!;
    if (_isTapped) return Colors.red[100]!;
    if (_isDoubleTapped) return Colors.purple[100]!;
    if (_isTwoFingerTapped) return Colors.yellow[100]!;
    return Colors.grey[200]!;
  }

  Color get dotColor {
    if (_isDragging) return Colors.green;
    if (_isTapped) return Colors.red;
    if (_isDoubleTapped) return Colors.purple;
    if (_isTwoFingerTapped) return Colors.yellow;
    return Colors.grey[300]!;
  }

  void startDragging(double x, double y) {
    _isDragging = true;
    _mouseX = x;
    _mouseY = y;
    notifyListeners();
  }

  void updateDragging(double deltaX, double deltaY) {
    _mouseX = (_mouseX + deltaX).clamp(40.0, 360.0);
    _mouseY = (_mouseY + deltaY).clamp(40.0, 360.0);
    notifyListeners();
  }

  void stopDragging() {
    _isDragging = false;
    _mouseX = 200; // Re-center
    _mouseY = 200; // Re-center
    notifyListeners();
  }

  void handleTap() {
    _isTapped = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200), () {
      _isTapped = false;
      notifyListeners();
    });
  }

  void handleDoubleTap() {
    _isDoubleTapped = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200), () {
      _isDoubleTapped = false;
      notifyListeners();
    });
  }

  void handleTwoFingerTap() {
    _isTwoFingerTapped = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200), () {
      _isTwoFingerTapped = false;
      notifyListeners();
    });
  }
}
