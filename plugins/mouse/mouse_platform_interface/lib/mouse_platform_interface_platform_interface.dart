import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mouse_platform_interface_method_channel.dart';

abstract class MousePlatformInterfacePlatform extends PlatformInterface {
  /// Constructs a MousePlatformInterfacePlatform.
  MousePlatformInterfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static MousePlatformInterfacePlatform _instance = MethodChannelMousePlatformInterface();

  /// The default instance of [MousePlatformInterfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelMousePlatformInterface].
  static MousePlatformInterfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MousePlatformInterfacePlatform] when
  /// they register themselves.
  static set instance(MousePlatformInterfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
