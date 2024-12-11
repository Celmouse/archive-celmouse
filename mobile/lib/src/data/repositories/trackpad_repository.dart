import 'package:controller/getit.dart';
import 'package:controller/src/data/models/vector2.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/domain/models/mouse_settings_model.dart';
import 'package:protocol/protocol.dart';

class TrackPadRepository {
  final ClientApiService _clientApiService;

  TrackPadRepository({
    required ClientApiService clientApiService,
  }) : _clientApiService = clientApiService;

  void handleDrag(double deltaX, double deltaY) {
    final sensitivity = getIt.get<MouseSettings>().sensitivity;

    final vector = Vector2D(deltaX, deltaY);

    if (!vector.canNormalize) return;

    Vector2D normalized = vector.normalized;

    _clientApiService.send(
      event: MouseProtocolEvents.mouseMove,
      data: MouseMovementProtocolData(
        x: normalized.x,
        y: normalized.y,
        intensity: sensitivity * vector.length / 10,
      ),
    );
  }

  void handleTap() {
    _clientApiService.send(
      event: MouseProtocolEvents.mouseClick,
      data: const MouseButtonProtocolData(type: MouseButton.left),
    );
  }

  void handleDoubleTap() {
    _clientApiService.send(
      event: MouseProtocolEvents.mouseDoubleClick,
      data: const MouseButtonProtocolData(type: MouseButton.left),
    );
  }

  void handleTwoFingerTap() {
    _clientApiService.send(
      event: MouseProtocolEvents.mouseClick,
      data: const MouseButtonProtocolData(type: MouseButton.right),
    );
  }
}
