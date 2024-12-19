import 'package:protocol_interface/protocol_interface.dart';

class ConnectionProtocolEvents extends ProtocolEvent {
  static const connectionInfo = ConnectionProtocolEvents('ConnectionInfo');
  static const connectionStatus = ConnectionProtocolEvents('ConnectionStatus');
  static const desktopToMobileData =
      ConnectionProtocolEvents('DesktopToMobileData');
  static const mobileToDesktopData =
      ConnectionProtocolEvents('MobileToDesktopData');

  const ConnectionProtocolEvents(super.name);
}
