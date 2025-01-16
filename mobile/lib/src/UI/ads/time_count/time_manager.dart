import 'package:controller/src/config/reward_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeManager with WidgetsBindingObserver {
  static final TimeManager _instance = TimeManager._internal();
  factory TimeManager() => _instance;
  TimeManager._internal() {
    WidgetsBinding.instance.addObserver(this);
  }

  static const String _expirationTimeKey = 'expiration_time';
  static const String _videosWatchedKey = 'videos_watched';
  DateTime? _lastPausedTime;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lastPausedTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      _handleResume();
    }
  }

  Future<void> addTime(Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    int currentExpirationTime = prefs.getInt(_expirationTimeKey) ?? 0;
    int newExpirationTime =
        DateTime.now().millisecondsSinceEpoch + duration.inMilliseconds;
    if (newExpirationTime > currentExpirationTime) {
      await prefs.setInt(_expirationTimeKey, newExpirationTime);
    }
  }

  Future<void> incrementVideosWatched() async {
    final prefs = await SharedPreferences.getInstance();
    int videosWatched = prefs.getInt(_videosWatchedKey) ?? 0;
    videosWatched++;
    await prefs.setInt(_videosWatchedKey, videosWatched);

    Duration rewardDuration;
    if (videosWatched % RewardConfig.videosForFreeDay == 0) {
      rewardDuration =
          RewardConfig.rewardForFiveVideos; // Free day after 5 videos
    } else if (videosWatched % 2 == 0) {
      rewardDuration = RewardConfig.rewardForTwoVideos; // 2h30 after 2 videos
    } else {
      rewardDuration = RewardConfig.rewardForEachVideo; // 1h for each video
    }

    await addTime(rewardDuration);
  }

  Future<Duration> getTimeLeft() async {
    final prefs = await SharedPreferences.getInstance();
    int expirationTime = prefs.getInt(_expirationTimeKey) ?? 0;
    if (expirationTime == 0) {
      return Duration.zero;
    }
    int timeLeft = expirationTime - DateTime.now().millisecondsSinceEpoch;
    if (timeLeft < 0) {
      return Duration.zero;
    }
    return Duration(milliseconds: timeLeft);
  }

  Future<void> resetTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_expirationTimeKey);
    await prefs.remove(_videosWatchedKey);
  }

  void _handleResume() async {
    final prefs = await SharedPreferences.getInstance();
    int expirationTime = prefs.getInt(_expirationTimeKey) ?? 0;
    if (expirationTime == 0) {
      return;
    }
    int timeElapsed = DateTime.now().millisecondsSinceEpoch -
        _lastPausedTime!.millisecondsSinceEpoch;
    int newExpirationTime = expirationTime - timeElapsed;
    if (newExpirationTime < DateTime.now().millisecondsSinceEpoch) {
      newExpirationTime = DateTime.now().millisecondsSinceEpoch;
    }
    await prefs.setInt(_expirationTimeKey, newExpirationTime);
  }
}
