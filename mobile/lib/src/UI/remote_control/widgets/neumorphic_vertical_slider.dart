/// This compoent is the first UI UX choice
///
library;

import 'package:controller/src/UI/remote_control/widgets/neumorphic_track_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerticalVolumeSlider extends StatefulWidget {
  final bool isDark;
  final Function(double) onVolumeChanged;
  final double trackHeight;

  const VerticalVolumeSlider({
    super.key,
    required this.isDark,
    required this.onVolumeChanged,
    this.trackHeight = 40,
  });

  @override
  State<VerticalVolumeSlider> createState() => VerticalVolumeSliderState();
}

class VerticalVolumeSliderState extends State<VerticalVolumeSlider> {
  double _volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: widget.trackHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: widget.trackHeight,
              overlayShape: SliderComponentShape.noOverlay,
              thumbShape:
                  const _NoThumbShape(), // Custom thumb shape to hide the thumb
              trackShape: NeumorphicRectSliderTrackShape(isDark: widget.isDark),
            ),
            child: RotatedBox(
              quarterTurns: 3, // Rotate the slider to make it vertical
              child: Slider(
                min: 0,
                max: 1,
                value: _volume,
                onChanged: (value) {
                  setState(() => _volume = value);
                  widget.onVolumeChanged(value);
                  if ((value * 100).round() % 10 == 0) {
                    HapticFeedback.mediumImpact();
                  }
                },
                inactiveColor: Colors.transparent,
              ),
            ),
          ),
          // + and - icons inside the slider
          Positioned(
            top: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: widget.isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
                const SizedBox(height: 190),
                Icon(
                  Icons.remove,
                  color: widget.isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
          // Audio icon in the middle
          Positioned(
            child: Icon(
              Icons.volume_up,
              color: widget.isDark ? Colors.white : Colors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoThumbShape extends SliderComponentShape {
  const _NoThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.zero;
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    // Do nothing to hide the thumb
  }
}


/// This component with animations collapse and first UI UX
// import 'package:controller/src/UI/remote_control/widgets/neumorphic_track_shape.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';

// class _NoThumbShape extends SliderComponentShape {
//   const _NoThumbShape();

//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.zero;
//   }

//   @override
//   void paint(
//     PaintingContext context,
//     Offset center, {
//     required Animation<double> activationAnimation,
//     required Animation<double> enableAnimation,
//     required bool isDiscrete,
//     required TextPainter labelPainter,
//     required RenderBox parentBox,
//     required SliderThemeData sliderTheme,
//     required TextDirection textDirection,
//     required double value,
//     required double textScaleFactor,
//     required Size sizeWithOverflow,
//   }) {
//     // Do nothing to hide the thumb
//   }
// }

// class VerticalVolumeSlider extends StatefulWidget {
//   final bool isDark;
//   final Function(double) onVolumeChanged;
//   final double trackHeight;

//   const VerticalVolumeSlider({
//     super.key,
//     required this.isDark,
//     required this.onVolumeChanged,
//     this.trackHeight = 45,
//   });

//   @override
//   VerticalVolumeSliderState createState() => VerticalVolumeSliderState();
// }

// class VerticalVolumeSliderState extends State<VerticalVolumeSlider>
//     with SingleTickerProviderStateMixin {
//   double _volume = 0.5;
//   bool _isExpanded = false;
//   late AnimationController _animationController;
//   late Animation<double> _heightAnimation;
//   Timer? _collapseTimer;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _heightAnimation =
//         Tween<double>(begin: widget.trackHeight, end: 270).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _collapseTimer?.cancel();
//     super.dispose();
//   }

//   void _toggleExpansion() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//       if (_isExpanded) {
//         _animationController.forward();
//         _startCollapseTimer();
//       } else {
//         _animationController.reverse();
//       }
//     });
//   }

//   void _startCollapseTimer() {
//     _collapseTimer?.cancel();
//     _collapseTimer = Timer(const Duration(seconds: 3), () {
//       if (mounted && _isExpanded) {
//         _toggleExpansion();
//       }
//     });
//   }

//   void _handleInteraction() {
//     if (_isExpanded) {
//       _startCollapseTimer();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleExpansion,
//       child: AnimatedBuilder(
//         animation: _animationController,
//         builder: (context, child) {
//           return SizedBox(
//             height: _heightAnimation.value,
//             width: widget.trackHeight,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SliderTheme(
//                   data: SliderTheme.of(context).copyWith(
//                     trackHeight: widget.trackHeight,
//                     overlayShape: SliderComponentShape.noOverlay,
//                     thumbShape: const _NoThumbShape(),
//                     trackShape:
//                         NeumorphicRectSliderTrackShape(isDark: widget.isDark),
//                   ),
//                   child: RotatedBox(
//                     quarterTurns: 3,
//                     child: Slider(
//                       min: 0,
//                       max: 1,
//                       value: _volume,
//                       onChanged: _isExpanded
//                           ? (value) {
//                               setState(() => _volume = value);
//                               widget.onVolumeChanged(value);
//                               if ((value * 100).round() % 10 == 0) {
//                                 HapticFeedback.mediumImpact();
//                               }
//                               _handleInteraction();
//                             }
//                           : null,
//                       activeColor: widget.isDark
//                           ? const Color.fromARGB(255, 190, 190, 190)
//                           : Colors.black,
//                       inactiveColor: Colors.grey.withOpacity(0.3),
//                     ),
//                   ),
//                 ),
//                 if (_isExpanded) ...[
//                   Positioned(
//                     top: 10,
//                     child: Icon(
//                       Icons.add,
//                       color: widget.isDark ? Colors.white : Colors.black,
//                       size: 20,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     child: Icon(
//                       Icons.remove,
//                       color: widget.isDark ? Colors.white : Colors.black,
//                       size: 20,
//                     ),
//                   ),
//                 ],
//                 Icon(
//                   _volume > 0 ? Icons.volume_up : Icons.volume_off,
//                   color: widget.isDark ? Colors.white : Colors.black,
//                   size: 20,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

/// This component with animations collapse and neumorphism button UI UX
///
///
///
// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class VerticalVolumeSlider extends StatefulWidget {
//   final bool isDark;
//   final Function(double) onVolumeChanged;
//   final double trackHeight;

//   const VerticalVolumeSlider({
//     super.key,
//     required this.isDark,
//     required this.onVolumeChanged,
//     this.trackHeight = 45,
//   });

//   @override
//   State<VerticalVolumeSlider> createState() => VerticalVolumeSliderState();
// }

// class VerticalVolumeSliderState extends State<VerticalVolumeSlider> {
//   double _volume = 0.5;
//   bool _isExpanded = false;
//   Timer? _inactivityTimer;

//   void _startInactivityTimer() {
//     _inactivityTimer?.cancel(); // Cancel any existing timer
//     _inactivityTimer = Timer(const Duration(seconds: 2), () {
//       setState(() {
//         _isExpanded = false; // Collapse after 2 seconds of inactivity
//       });
//     });
//   }

//   void _handleInteraction() {
//     setState(() {
//       _isExpanded = true; // Expand on interaction
//     });
//     _startInactivityTimer(); // Restart the inactivity timer
//   }

//   void _adjustVolume(double delta) {
//     setState(() {
//       _volume = (_volume + delta)
//           .clamp(0.0, 1.0); // Ensure volume stays within [0, 1]
//       widget.onVolumeChanged(_volume);
//       HapticFeedback.lightImpact(); // Provide haptic feedback
//     });
//     _handleInteraction(); // Restart the inactivity timer
//   }

//   @override
//   void dispose() {
//     _inactivityTimer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _handleInteraction,
//       onVerticalDragUpdate: (_) => _handleInteraction(),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//         height: _isExpanded ? 270 : 60, // Height when expanded vs collapsed
//         width: widget.trackHeight,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: _isExpanded
//               ? widget.isDark
//                   ? Colors.black.withOpacity(0.7)
//                   : Colors.white.withOpacity(0.7)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: _isExpanded
//               ? [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 4),
//                   ),
//                 ]
//               : [],
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Blurred background for expanded state
//             if (_isExpanded)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: BackdropFilter(
//                   filter: widget.isDark
//                       ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
//                       : ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                   child: Container(
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ),
//             // Slider (only visible when expanded)
//             if (_isExpanded)
//               SliderTheme(
//                 data: SliderTheme.of(context).copyWith(
//                   trackHeight: widget.trackHeight,
//                   overlayShape: SliderComponentShape.noOverlay,
//                   thumbShape: const _NoThumbShape(), // Hide the thumb
//                   trackShape:
//                       NeumorphicRectSliderTrackShape(isDark: widget.isDark),
//                 ),
//                 child: RotatedBox(
//                   quarterTurns: 3, // Rotate the slider to make it vertical
//                   child: Slider(
//                     min: 0,
//                     max: 1,
//                     value: _volume,
//                     onChanged: (value) {
//                       setState(() => _volume = value);
//                       widget.onVolumeChanged(value);
//                       if ((value * 100).round() % 10 == 0) {
//                         HapticFeedback.lightImpact(); // Subtle haptic feedback
//                       }
//                       _handleInteraction(); // Restart timer on slider interaction
//                     },
//                     inactiveColor: Colors.transparent,
//                   ),
//                 ),
//               ),
//             // + and - icons inside the slider (only visible when expanded)
//             if (_isExpanded)
//               Positioned(
//                 top: 10,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // + Button
//                     GestureDetector(
//                       onTap: () => _adjustVolume(0.1), // Increase volume by 10%
//                       child: Icon(
//                         Icons.add,
//                         color: widget.isDark ? Colors.white : Colors.black,
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(height: 190),
//                     // - Button
//                     GestureDetector(
//                       onTap: () =>
//                           _adjustVolume(-0.1), // Decrease volume by 10%
//                       child: Icon(
//                         Icons.remove,
//                         color: widget.isDark ? Colors.white : Colors.black,
//                         size: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             // Audio icon in the middle (always visible)
//             AnimatedSwitcher(
//               duration: const Duration(milliseconds: 300),
//               child: _isExpanded
//                   ? Container() // Hide the icon when expanded
//                   : Icon(
//                       _volume == 0
//                           ? Icons.volume_off
//                           : Icons.volume_up, // Muted icon at 0 volume
//                       key: ValueKey(_volume), // Unique key for animation
//                       color: widget.isDark ? Colors.white : Colors.black,
//                       size: 24,
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _NoThumbShape extends SliderComponentShape {
//   const _NoThumbShape();

//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.zero;
//   }

//   @override
//   void paint(
//     PaintingContext context,
//     Offset center, {
//     required Animation<double> activationAnimation,
//     required Animation<double> enableAnimation,
//     required bool isDiscrete,
//     required TextPainter labelPainter,
//     required RenderBox parentBox,
//     required SliderThemeData sliderTheme,
//     required TextDirection textDirection,
//     required double value,
//     required double textScaleFactor,
//     required Size sizeWithOverflow,
//   }) {
//     // Do nothing to hide the thumb
//   }
// }

// class NeumorphicRectSliderTrackShape extends SliderTrackShape {
//   @override
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final double trackHeight = sliderTheme.trackHeight ?? 2.0;
//     final double trackLeft = offset.dx;
//     final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
//     final double trackWidth = parentBox.size.width;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
//   final bool isDark;

//   const NeumorphicRectSliderTrackShape({required this.isDark});

//   @override
//   void paint(
//     PaintingContext context,
//     Offset offset, {
//     required RenderBox parentBox,
//     required SliderThemeData sliderTheme,
//     required Animation<double> enableAnimation,
//     required TextDirection textDirection,
//     required Offset thumbCenter,
//     Offset? secondaryOffset,
//     bool isDiscrete = false,
//     bool isEnabled = false,
//   }) {
//     final canvas = context.canvas;
//     final trackPaint = Paint()
//       ..color = isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF0F0F0)
//       ..style = PaintingStyle.fill;

//     final trackRect = Rect.fromLTWH(
//       offset.dx,
//       offset.dy,
//       parentBox.size.width,
//       parentBox.size.height,
//     );

//     // Draw the track
//     canvas.drawRect(trackRect, trackPaint);

//     // Draw the active track
//     final activeTrackPaint = Paint()
//       ..color = isDark ? const Color(0xFF3D3D3D) : const Color(0xFFE0E0E0)
//       ..style = PaintingStyle.fill;

//     final activeTrackRect = Rect.fromLTWH(
//       offset.dx,
//       offset.dy,
//       thumbCenter.dx - offset.dx,
//       parentBox.size.height,
//     );

//     canvas.drawRect(activeTrackRect, activeTrackPaint);
//   }
// }
