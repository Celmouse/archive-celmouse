import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mouse_platform_interface.dart';

/// An implementation of [MousePlatform] that uses method channels.
class MethodChannelMouse extends MousePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mouse');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
