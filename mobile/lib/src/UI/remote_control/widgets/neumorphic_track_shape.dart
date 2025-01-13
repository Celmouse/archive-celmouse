import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NeumorphicRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  final bool isDark;

  const NeumorphicRectSliderTrackShape({
    required this.isDark,
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final trackHeight = sliderTheme.trackHeight!;
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint activePaint = Paint();
    final Paint inactivePaint = Paint()
      ..color = isDark ? const Color(0xFF2C2C2E) : const Color(0xffebecf0);

    // Reduced rounded corners by 10px
    final Radius trackRadius = Radius.circular(trackRect.height / 2 - 10);

    // Clip the entire track area
    context.canvas.clipRRect(
      RRect.fromLTRBR(trackRect.left, trackRect.top, trackRect.right,
          trackRect.bottom, trackRadius),
    );

    // Background with inner shadow
    final Paint shadowPaint = Paint()
      ..color = isDark ? Colors.black.withOpacity(0.5) : const Color(0xffb3b6c7)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        ui.Shadow.convertRadiusToSigma(15),
      );

    // Draw background with inner shadow
    context.canvas.drawRRect(
      RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        trackRadius,
      ),
      inactivePaint,
    );

    // Draw inner shadow
    context.canvas.drawRRect(
      RRect.fromLTRBR(
        trackRect.left - trackHeight,
        trackRect.top + trackHeight / 8,
        trackRect.right - trackHeight / 8,
        trackRect.bottom,
        trackRadius,
      ),
      shadowPaint,
    );

    // Active track gradient
    activePaint.shader = ui.Gradient.linear(
      Offset(trackRect.left, trackRect.top),
      Offset(thumbCenter.dx, trackRect.top),
      isDark
          ? [
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.6),
            ]
          : [
              const Color(0xff0f3dea),
              const Color(0xff2069f4),
            ],
    );

    // Draw active track
    context.canvas.drawRRect(
      RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        thumbCenter.dx,
        trackRect.bottom,
        trackRadius,
      ),
      activePaint,
    );
  }
}
