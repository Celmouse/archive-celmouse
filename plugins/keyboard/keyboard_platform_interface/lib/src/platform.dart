import 'package:keyboard_protocol/keyboard_protocol.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'interface.dart';

abstract class KeyboardPlatform extends PlatformInterface
    implements KeyboardInterface {
  /// Constructs a KeyboardPlatformInterfacePlatform.
  KeyboardPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeyboardPlatform? _instance;

  /// The default instance of [KeyboardPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeyboardPlatformInterface].
  static KeyboardPlatform get instance {
    if (_instance == null) {
      throw UnimplementedError('No platform implementation set.');
    }
    return _instance!;
  }

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KeyboardPlatform] when
  /// they register themselves.
  static set instance(KeyboardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  @override
  void pressKey(String key);

  @override
  void releaseKey(String key);

  @override
  void pressSpecialKey(SpecialKeyType key);

  @override
  void releaseSpecialKey(SpecialKeyType key);
}
