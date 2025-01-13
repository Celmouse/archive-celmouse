import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MouseModeSwitch extends StatefulWidget {
  final ValueChanged<int> onToggle;
  final int currentIndex;

  const MouseModeSwitch({
    super.key,
    required this.onToggle,
    required this.currentIndex,
  });

  @override
  MouseModeSwitchState createState() => MouseModeSwitchState();
}

class MouseModeSwitchState extends State<MouseModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'mouse-mode-switch',
      child: ToggleSwitch(
        initialLabelIndex: widget.currentIndex,
        totalSwitches: 3,
        inactiveBgColor: Colors.deepPurpleAccent,
        activeBgColor: const [Colors.teal],
        minWidth: MediaQuery.of(context).size.width,
        icons: const [
          Icons.phonelink_ring_outlined,
          Icons.touch_app,
          Icons.settings_remote,
        ],
        labels: const [
          'Move',
          'Touch',
          'Remote',
        ],
        onToggle: (index) {
          if (index != null) {
            widget.onToggle(index);
          }
        },
      ),
    );
  }
}
