import 'package:mouse_protocol/mouse_protocol.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'interface.dart';

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  @override
  void move(double x, double y) {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  void moveTo(double x, double y) {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  (int x, int y) getScreenSize() {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  void holdLeftButton() {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  void click(MouseButton button) {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  void releaseLeftButton() {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  void doubleClick() {
    throw UnimplementedError('Implementar o metodo');
  }

  @override
  void scroll(int x, int y, int amount) {
    throw UnimplementedError('Implementar o metodo');
  }
}
