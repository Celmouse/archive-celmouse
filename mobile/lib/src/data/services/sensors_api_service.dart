import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vectors;

class SensorsApiService {
  DateTime? tmpTimestamp;

  Stream<(double x, double y)> gyroscope(
    bool invertX,
    bool invertY,
    double threshold,
  ) {
    return gyroscopeEventStream(
      samplingPeriod: const Duration(milliseconds: 16, microseconds: 666),
    ).map<(double x, double y)>((event) {
      var (x, y) = _tranformGyroscopeCoordinates(
        event.z * -1,
        event.x * -1,
        event.timestamp,
      );

      if (x.abs() <= threshold) {
        x = 0;
      }

      if (y.abs() <= threshold) {
        y = 0;
      }

      final invertedX = invertX ? -1 : 1;
      final invertedY = invertY ? -1 : 1;

      return (invertedX * x, invertedY * y);
    });
  }

  (double x, double y) _tranformGyroscopeCoordinates(
    double x,
    double y,
    DateTime timestamp,
  ) {
    if (tmpTimestamp == null) {
      tmpTimestamp = timestamp;
      return (0, 0);
    }

    // X é Z e pra direita é negativo
    // X é Y e pra cima é positivo
    final diffMS = timestamp.difference(tmpTimestamp!).inMicroseconds;
    tmpTimestamp = timestamp;

    print(diffMS);

    // Ensure no jumps
    if (diffMS > 16300) {
      return (0, 0);
    }

    final seconds = diffMS / pow(10, 6);

    x = (vectors.degrees(x * seconds));
    y = (vectors.degrees(y * seconds));

    return (x, y);
  }
}
