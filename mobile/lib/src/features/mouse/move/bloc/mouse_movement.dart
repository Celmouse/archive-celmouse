import 'dart:async';
import 'dart:math';
import 'package:controller/getit.dart';
import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../data/mouse_settings_model.dart';
import '../../socket_mouse.dart';
import 'package:vector_math/vector_math.dart' as math;
import 'package:protocol/protocol.dart';

class MouseMovement {
  final MouseControl mouse;

  final ValueNotifier<bool> gyroscopeError = ValueNotifier<bool>(false);

  MouseMovement({
    required this.mouse,
  });

  // var gyroscopePointer = (x: 0, y: 0);

  DateTime? lastTimeGyroscopeMouseMovement;

  StreamSubscription? moveGyroscopeSubscription;
  StreamSubscription? moveAccelerometerSubscription;
  StreamSubscription? scrollGyroscopeSubscription;

  dispose() {
    moveGyroscopeSubscription?.cancel();
    moveAccelerometerSubscription?.cancel();
    scrollGyroscopeSubscription?.cancel();
  }

  stopMouseMovement() {
    moveGyroscopeSubscription?.cancel();
    moveGyroscopeSubscription = null;
  }

  startAccelerometerMovement() {
    // lastTimeGyroscopeMouseMovement = DateTime.now();
    moveAccelerometerSubscription ??= userAccelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen(
        (
          UserAccelerometerEvent event,
        ) {
          print(event);
          if (isMovementPaused) {
            return;
          }
          // var (x, y) = _tranformGyroscopeCoordinates(
          //   event.x,
          //   event.y,
          //   event.timestamp,
          // );

          // final threshold = getIt.get<MouseSettings>().vibrationThreshold.value;

          // if (x.abs() <= threshold) {
          //   x = 0;
          // }

          // if (y.abs() <= threshold) {
          //   y = 0;
          // }

          // final invertedX =
          //     getIt.get<MouseSettings>().invertedPointerX ? -1 : 1;
          // final invertedY =
          //     getIt.get<MouseSettings>().invertedPointerY ? -1 : 1;
          mouse.move(-1 * event.x / 30, event.z / 30);
        },
        cancelOnError: true,
        onError: (err, stack) {
          gyroscopeError.value = true;
        });
  }

  bool isMovementPaused = false;

  /// When user starts scrolling the movement will be paused
  pauseMouseMovement() {
    isMovementPaused = true;
  }

  stopScrollMovement() {
    scrollGyroscopeSubscription?.cancel();
    scrollGyroscopeSubscription = null;
    isMovementPaused = false;
  }

  startScrollMovement() {
    lastTimeGyroscopeMouseMovement = DateTime.now();

    scrollGyroscopeSubscription ??= gyroscopeEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen(
        (
          GyroscopeEvent event,
        ) {
          var (x, y) = _tranformGyroscopeCoordinates(
            event.z * -1,
            event.x * -1,
            event.timestamp,
          );

          if (x.abs() <= MouseSettings.scrollThreshholdX) {
            x = 0;
          }

          if (y.abs() <= MouseSettings.scrollThreshholdY) {
            y = 0;
          }

          sendScrollMovement(x, y);
          //TODO: Remover na versão 3.0
          _sendScrollMovement(x, y);
        },
        cancelOnError: true,
        onError: (err, stack) {
          gyroscopeError.value = true;
        });
  }

  startMouseMovement() {
    lastTimeGyroscopeMouseMovement = DateTime.now();

    moveGyroscopeSubscription ??= gyroscopeEventStream(
      samplingPeriod: const Duration(milliseconds: 16, microseconds: 666),
    ).listen(
        (
          GyroscopeEvent event,
        ) {
          if (isMovementPaused) {
            return;
          }
          var (x, y) = _tranformGyroscopeCoordinates(
            event.z * -1,
            event.x * -1,
            event.timestamp,
          );

          final threshold = getIt.get<MouseSettings>().vibrationThreshold.value;

          if (x.abs() <= threshold) {
            x = 0;
          }

          if (y.abs() <= threshold) {
            y = 0;
          }

          final invertedX =
              getIt.get<MouseSettings>().invertedPointerX ? -1 : 1;
          final invertedY =
              getIt.get<MouseSettings>().invertedPointerY ? -1 : 1;
          mouse.move(invertedX * x, invertedY * y);
        },
        cancelOnError: true,
        onError: (err, stack) {
          gyroscopeError.value = true;
        });
  }

  (double x, double y) _tranformGyroscopeCoordinates(
    double x,
    double y,
    DateTime timestamp,
  ) {
    // X é Z e pra direita é negativo
    // X é Y e pra cima é positivo
    final diffMS = timestamp
        .difference(
          lastTimeGyroscopeMouseMovement!,
        )
        .inMicroseconds;
    lastTimeGyroscopeMouseMovement = timestamp;

    final seconds = diffMS / pow(10, 6);

    x = (math.degrees(x * seconds));
    y = (math.degrees(y * seconds));

    return (x, y);
  }

  @Deprecated('Use sendScrollMovement instead')
  _sendScrollMovement(double x, double y) {
    ScrollDirections direction;

    if (x.abs() > y.abs()) {
      direction =
          ((getIt.get<MouseSettings>().invertedScrollX ? 1 : -1) * x.sign < 0)
              ? ScrollDirections.left
              : ScrollDirections.right;
    } else if ((x.abs() < y.abs())) {
      direction =
          ((getIt.get<MouseSettings>().invertedScrollY ? 1 : -1) * y.sign < 0)
              ? ScrollDirections.down
              : ScrollDirections.up;
    } else {
      return;
    }
    mouse.performScroll(direction);
    // Daqui pra cima é tudo deprecated

    // Preciso enviar de uma forma que não pode quebrar.
  }

  /// Envia o movimento do scroll com base nas coordenadas, enviando apenas 1 eixo
  sendScrollMovement(double x, double y) {
    final sensitivity = getIt.get<MouseSettings>().scrollSensitivity;
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

    mouse.scroll(x, y);
  }
}



/*
  (double x, double y) transformAcelerometerCoordinates(
    double x,
    double y,
    DateTime timestamp,
  ) {
    // X é X e pra direita é negativo
    // Z é Y e pra cima é negativo
    // (x, y) = (x / 50, y / 50);
    final diffMS =
        timestamp.difference(lastAccelerometerMovement!).inMicroseconds;
    lastAccelerometerMovement = timestamp;

    final seconds = diffMS / pow(10, 6);

    x = ((x / seconds));
    y = ((y / seconds));

    (x, y) = (x.abs() * gyroscopePointer.x, y.abs() * gyroscopePointer.y);
    // x = (math.degrees(x * seconds));
    // y = (math.degrees(y * seconds));

    return (x, y);
  }
  */
