import 'dart:async';
import 'package:controller/src/UI/ads/time_count/time_manager.dart';
import 'package:flutter/material.dart';

class TimeLeftWidget extends StatefulWidget {
  const TimeLeftWidget({super.key});

  @override
  TimeLeftWidgetState createState() => TimeLeftWidgetState();
}

class TimeLeftWidgetState extends State<TimeLeftWidget> {
  late Timer _timer;
  Duration _timeLeft = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeLeft();
    });
  }

  void _updateTimeLeft() async {
    final timeManager = TimeManager();
    final timeLeft = await timeManager.getTimeLeft();
    setState(() {
      _timeLeft = timeLeft;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Go premium version for free',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          _formatDuration(_timeLeft),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
