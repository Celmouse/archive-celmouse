import 'dart:async';

import 'package:controller/getit.dart';
import 'package:controller/src/data/services/client_api_service.dart';
import 'package:controller/src/data/services/sensors_api_service.dart';
import 'package:controller/src/features/mouse/move/data/mouse_settings_model.dart';
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

    movementSubscription ??= _sensorsService
        .gyroscope(
          invertX,
          invertY,
          threshold,
        )
        .listen(
          (event) => _clientApiService.send(
            event: ProtocolEvents.mouseMove,
            data: MouseMovementProtocolData(x: event.$1, y: event.$2),
          ),
        );
  }

  void disableMovement() {
    movementSubscription?.cancel();
    movementSubscription = null;
  }

  void click(ClickType type) {
    _clientApiService.send(
      event: ProtocolEvents.mouseClick,
      data: MouseButtonProtocolData(type: type),
    );
  }

  void doubleClick() {
    _clientApiService.send(
      event: ProtocolEvents.mouseDoubleClick,
      data: const MouseButtonProtocolData(type: ClickType.left),
    );
  }

  void disableScrolling() {
    scrollingSubscription?.cancel();
    scrollingSubscription = null;
  }

  void enableScrolling() {
    final sensitivity = getIt.get<MouseSettings>().scrollSensitivity;
    const threshold = MouseSettings.scrollThreshholdY;

    final bool invertX = getIt.get<MouseSettings>().invertedScrollX;
    final bool invertY = getIt.get<MouseSettings>().invertedScrollY;

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
        if (x != 0) {
          x = x / (x.abs()) * sensitivity;
        }
        if (y != 0) {
          y = y / (y.abs()) * sensitivity;
        }

        //TODO: Implement movement via coordinates at HUB

        _clientApiService.send(
          event: ProtocolEvents.mouseScroll,
          data: MouseMovementProtocolData(x: x, y: y),
        );
      },
    );
  }
}
