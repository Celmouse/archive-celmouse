import 'package:flutter/material.dart';
import 'package:controller/src/UI/ads/manager/ad_manager.dart';
import 'package:controller/src/config/reward_config.dart';

class TVLogosWidget extends StatefulWidget {
  final int itemCount;

  const TVLogosWidget({super.key, required this.itemCount});

  @override
  TVLogosWidgetState createState() => TVLogosWidgetState();
}

class TVLogosWidgetState extends State<TVLogosWidget> {
  final AdManager adManager = AdManager();
  final List<bool> _isWatched = [];
  final List<Duration> _timeEarned = [];
  int _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _isWatched.addAll(List<bool>.filled(widget.itemCount, false));
    _timeEarned.addAll(List<Duration>.generate(
        widget.itemCount, (index) => _calculateTimeEarned(index)));

    adManager.onRewardEarned = _onRewardEarned;
  }

  void _onRewardEarned() {
    setState(() {
      if (_currentIndex != -1) {
        _isWatched[_currentIndex] = true;
        _timeEarned[_currentIndex] = _calculateTimeEarned(_currentIndex);
        _currentIndex = -1;
      }
    });
  }

  Duration _calculateTimeEarned(int index) {
    if (index == 0) {
      return RewardConfig.rewardForEachVideo;
    } else if (index == 1) {
      return RewardConfig.rewardForTwoVideos;
    } else if (index == 4) {
      return RewardConfig.rewardForFiveVideos;
    } else {
      return RewardConfig.rewardForEachVideo;
    }
  }

  void _handleIconTap(int index) async {
    if (_isWatched[index]) return; // Prevent clicking if already watched
    if (index > 0 && !_isWatched[index - 1]) return; // Prevent skipping rewards

    if (adManager.isRewardedAdReady) {
      setState(() {
        _currentIndex = index;
      });
      await adManager.showRewardedAd();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ad not ready yet.'),
        ),
      );
      print('Ad not ready yet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _handleIconTap(index),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.smart_display,
                    size: 50,
                    color: _isWatched[index]
                        ? Colors.green
                        : (adManager.isRewardedAdReady
                            ? Colors.blue
                            : Colors.grey),
                  ),
                  Text(
                    '${_formatDuration(_timeEarned[index])} hr',
                    style: TextStyle(
                        fontSize: 12,
                        color: _isWatched[index] ? Colors.green : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    return '$hours:$minutes';
  }
}
