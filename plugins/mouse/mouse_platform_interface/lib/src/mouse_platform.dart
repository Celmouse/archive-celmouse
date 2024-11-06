import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class MouseMovement {
  void move(double x, double y);
  void moveTo(double x, double y);
}

abstract class MousePlatform extends PlatformInterface
    implements MouseMovement {
  /// Constructs a MousePlatformInterfacePlatform.
  MousePlatform() : super(token: _token);

  static final Object _token = Object();

  static MousePlatform? _instance;

  static MousePlatform get instance {
    if (_instance == null) {
      throw UnimplementedError('No platform implementation set.');
    }
    return _instance!;
  }

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MousePlatform] when
  /// they register themselves.
  static set instance(MousePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  @override
  void move(double x, double y) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  @override
  void moveTo(double x, double y) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
