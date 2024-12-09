import 'package:controller/src/data/services/client_api_service.dart';
import 'package:protocol/protocol.dart';

class KeyboardRepository {
  final ClientApiService _clientApiService;

  KeyboardRepository({
    required ClientApiService clientApiService,
  }) : _clientApiService = clientApiService;

  void type(String text) {
    _clientApiService.send(
      event: ProtocolEvents.keyPressed,
      data: text,
    );
  }

  void specialKey(SpecialKeyType type) {
    _clientApiService.send(
      event: ProtocolEvents.specialKeyPressed,
      data: type.toString(),
    );
  }
}

//TODO: This guy should be located at protocol level if it has to be used in hub
enum SpecialKeyType {
  shift,
  backspace,
  specialChars,
  space,
  enter,
  defaultLayout,
  // Add other special key types here
}
