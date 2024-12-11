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

  void handleDrag(double x, double y) {
    final vector = Vector2D(x, y);

    if (!vector.canNormalize) return;

    Vector2D normalized = vector.normalized;

    _clientApiService.send(
      event: ProtocolEvents.mouseMove,
      data: MouseMovementProtocolData(
        x: normalized.x,
        y: normalized.y,
        intensity: 0.1, // You can adjust the intensity as needed
      ),
    );
  }

  void handleTap() {
    _clientApiService.send(
      event: ProtocolEvents.mouseClick,
      data: const MouseButtonProtocolData(type: ClickType.left),
    );
  }

  void handleDoubleTap() {
    _clientApiService.send(
      event: ProtocolEvents.mouseDoubleClick,
      data: const MouseButtonProtocolData(type: ClickType.left),
    );
  }

  void handleTwoFingerTap() {
    _clientApiService.send(
      event: ProtocolEvents.mouseClick,
      data: const MouseButtonProtocolData(type: ClickType.right),
    );
  }
}
