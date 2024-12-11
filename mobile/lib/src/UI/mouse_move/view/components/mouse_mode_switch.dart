import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MouseModeSwitch extends StatefulWidget {
  const MouseModeSwitch({super.key});

  @override
  State<MouseModeSwitch> createState() => _MouseModeSwitchState();
}

class _MouseModeSwitchState extends State<MouseModeSwitch> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox(); // Hide in release mode

    return Hero(
      tag: 'mouse-mode-switch',
      child: ToggleSwitch(
        initialLabelIndex: _currentIndex,
        totalSwitches: 3,
        inactiveBgColor: Colors.deepPurpleAccent,
        activeBgColor: const [Colors.teal],
        minWidth: MediaQuery.of(context).size.width,
        icons: const [
          Icons.phonelink_ring_outlined,
          Icons.touch_app,
          Icons.mouse,
        ],
        labels: const [
          'Move',
          'Touch',
          'Drag',
        ],
        onToggle: (index) {
          if (index != null) {
            setState(() {
              _currentIndex = index;
            });
            print('Switched to: $index');
          }
        },
      ),
    );
  }
}
