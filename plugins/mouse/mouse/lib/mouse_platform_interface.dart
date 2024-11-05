import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mouse_method_channel.dart';

abstract class MousePlatform extends PlatformInterface {
  /// Constructs a MousePlatform.
  MousePlatform() : super(token: _token);

  static final Object _token = Object();

  static MousePlatform _instance = MethodChannelMouse();

  /// The default instance of [MousePlatform] to use.
  ///
  /// Defaults to [MethodChannelMouse].
  static MousePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MousePlatform] when
  /// they register themselves.
  static set instance(MousePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
