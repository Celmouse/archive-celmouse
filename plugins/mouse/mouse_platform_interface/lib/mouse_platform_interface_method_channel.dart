import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mouse_platform_interface_platform_interface.dart';

/// An implementation of [MousePlatformInterfacePlatform] that uses method channels.
class MethodChannelMousePlatformInterface extends MousePlatformInterfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mouse_platform_interface');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
