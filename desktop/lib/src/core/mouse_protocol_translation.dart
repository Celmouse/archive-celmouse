import 'package:protocol/protocol.dart';
import 'package:mouse/mouse.dart' as plugin;

/// This file acts as a glue to the "Protocol <-> Mouse Plugin"
extension EMousePluginProtocol on ClickType {
  plugin.MouseButton toMousePluginButton()=> plugin.MouseButton.values[index];
}