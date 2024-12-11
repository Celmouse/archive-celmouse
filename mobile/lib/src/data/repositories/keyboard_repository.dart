import 'package:controller/src/data/services/client_api_service.dart';
import 'package:protocol/protocol.dart';

class KeyboardRepository {
  final ClientApiService _clientApiService;

  KeyboardRepository({
    required ClientApiService clientApiService,
  }) : _clientApiService = clientApiService;

  void type(String text) {
    _clientApiService.send(
      event: KeyboardProtocolEvents.keyPressed,
      data: text,
    );
  }

  void specialKey(SpecialKeyType type) {
    _clientApiService.send(
      event: KeyboardProtocolEvents.specialKeyPressed,
      data: KeyboardProtocolData(
        key: type,
      ),
    );
  }
}
