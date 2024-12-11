import 'dart:async';

import 'package:controller/getit.dart';
import 'package:controller/src/data/models/vector2.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/data/services/sensors_api_service.dart';
import 'package:controller/src/domain/models/mouse_settings_model.dart';
import 'package:protocol/protocol.dart';

class MouseRepository {
  final ClientApiService _clientApiService;
  final SensorsApiService _sensorsService;

  MouseRepository({
    required ClientApiService clientApiService,
    required SensorsApiService sensorsService,
  })  : _clientApiService = clientApiService,
        _sensorsService = sensorsService;

  StreamSubscription? movementSubscription;
  StreamSubscription? scrollingSubscription;

  void enableMovement() {
    final double threshold =
        getIt.get<MouseSettings>().vibrationThreshold.value;
    final bool invertX = getIt.get<MouseSettings>().invertedPointerX;
    final bool invertY = getIt.get<MouseSettings>().invertedPointerY;
    final sensitivity = getIt.get<MouseSettings>().sensitivity;

    if (movementSubscription?.isPaused ?? false) {
      movementSubscription?.resume();
      return;
    }

    movementSubscription ??= _sensorsService
        .gyroscope(
      invertX,
      invertY,
      threshold,
    )
        .listen(
      (event) {
        var (x, y) = event;

        final vector = Vector2D(x, y);

        if (!vector.canNormalize) return;
        Vector2D normalized = vector.normalized;

        _clientApiService.send(
          event: ProtocolEvent.mouseMove,
          data: MouseMovementProtocolData(
            x: normalized.x,
            y: normalized.y,
            intensity: vector.length * sensitivity,
          ),
        );
      },
    );
  }

  void disableMovement() {
    movementSubscription?.pause(); // .cancel();
    // movementSubscription = null;
  }

  void click(ClickType type) {
    _clientApiService.send(
      event: ProtocolEvent.mouseClick,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void doubleClick() {
    _clientApiService.send(
      event: ProtocolEvent.mouseDoubleClick,
      data: const MouseButtonProtocolData(type: ClickType.left),
    );
  }

  void disableScrolling() {
    scrollingSubscription?.pause();
  }

  void enableScrolling() {
    final sensitivity = getIt.get<MouseSettings>().scrollSensitivity;
    const threshold = MouseSettings.scrollThreshholdY;

    final bool invertX = getIt.get<MouseSettings>().invertedScrollX;
    final bool invertY = getIt.get<MouseSettings>().invertedScrollY;

    if (scrollingSubscription?.isPaused ?? false) {
      scrollingSubscription?.resume();
      return;
    }

    scrollingSubscription ??= _sensorsService
        .gyroscope(
      invertX,
      invertY,
      threshold,
    )
        .listen(
      (event) {
        var (x, y) = event;

        if (x.abs() > y.abs()) {
          y = 0;
        } else {
          x = 0;
        }

        final vector = Vector2D(x, y);
        if (!vector.canNormalize) return;
        Vector2D normalized = vector.normalized;

        _clientApiService.send(
          event: ProtocolEvent.mouseScroll,
          data: MouseMovementProtocolData(
            x: normalized.x,
            y: normalized.y,
            intensity: vector.length * sensitivity,
          ),
        );
      },
    );
  }
}