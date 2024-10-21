import 'dart:async';
import 'dart:math';
import 'package:controller/getit.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../socket/mouse.dart';
import 'package:vector_math/vector_math.dart' as math;

import '../socket/protocol.dart';

class MouseMovement {
  final MouseControl mouse;

  MouseMovement({
    required this.mouse,
  });

  // var gyroscopePointer = (x: 0, y: 0);

  DateTime? lastTimeGyroscopeMouseMovement;

  StreamSubscription? moveGyroscopeSubscription;
  StreamSubscription? scrollGyroscopeSubscription;

  stopMouseMovement() {
    moveGyroscopeSubscription?.cancel();
    moveGyroscopeSubscription = null;
  }

  stopScrollMovement() {
    scrollGyroscopeSubscription?.cancel();
    scrollGyroscopeSubscription = null;
  }

  startScrollMovement() {
    lastTimeGyroscopeMouseMovement = DateTime.now();

    scrollGyroscopeSubscription ??= gyroscopeEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen((
      GyroscopeEvent event,
    ) {
      var (x, y) = _tranformGyroscopeCoordinates(
        event.z * -1,
        event.x * -1,
        event.timestamp,
      );

      if (x.abs() <= MouseConfigs.scrollThreshholdX) {
        x = 0;
      }

      if (y.abs() <= MouseConfigs.scrollThreshholdY) {
        y = 0;
      }

      _sendScrollMovement(x, y);

      // print('Cursor Scroll');
      // print("X: $x");
      // print("Y: $y");
      // print("\n####\n####\n");
    });
  }

  startMouseMovement() {
    lastTimeGyroscopeMouseMovement = DateTime.now();

    moveGyroscopeSubscription ??= gyroscopeEventStream(
      samplingPeriod: const Duration(milliseconds: 10),
    ).listen(
      (
        GyroscopeEvent event,
      ) {
        var (x, y) = _tranformGyroscopeCoordinates(
          event.z * -1,
          event.x * -1,
          event.timestamp,
        );

        if (x.abs() <= MouseConfigs.threshholdX) {
          x = 0;
        }

        if (y.abs() <= MouseConfigs.threshholdY) {
          y = 0;
        }

        mouse.move(
          (getIt.get<MouseConfigs>().invertedPointerX ? -1 : 1 ) * x,
          (getIt.get<MouseConfigs>().invertedPointerY ? -1 : 1 ) * y,
        );
      },
    );
  }

  startScrolling() {}

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

  _sendScrollMovement(double x, double y) {
    String direction = "";

    if (x.abs() > y.abs()) {
      direction =
          ((getIt.get<MouseConfigs>().invertedScrollX ? 1 : -1) * x.sign < 0)
              ? ScrollDirections.left
              : ScrollDirections.right;
    } else if ((x.abs() < y.abs())) {
      direction =
          ((getIt.get<MouseConfigs>().invertedScrollY ? 1 : -1) * y.sign < 0)
              ? ScrollDirections.down
              : ScrollDirections.up;
    }

    mouse.scroll(direction);
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
