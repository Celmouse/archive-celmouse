// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart' as rive;

// class NeumorphicButton extends StatefulWidget {
//   final IconData? icon;
//   final String? imagePath;
//   final VoidCallback? onPressed;
//   final bool isDark;
//   final bool isCircular;
//   final double size;
//   final bool isActive;
//   final String? riveAnimationPath;
//   final String? riveAnimationName;

//   const NeumorphicButton({
//     super.key,
//     this.icon,
//     this.imagePath,
//     this.onPressed,
//     this.isDark = true,
//     this.isCircular = true,
//     this.size = 45,
//     this.isActive = false,
//     this.riveAnimationPath,
//     this.riveAnimationName,
//   });

//   @override
//   State<NeumorphicButton> createState() => _NeumorphicButtonState();
// }

// class _NeumorphicButtonState extends State<NeumorphicButton> {
//   bool _isPressed = false;
//   bool _isActive = false;
//   rive.RiveAnimationController? _riveController;

//   @override
//   void initState() {
//     super.initState();
//     _isActive = widget.isActive;
//     if (widget.riveAnimationPath != null) {
//       _initializeRiveAnimation();
//     }
//   }

//   void _initializeRiveAnimation() {
//     try {
//       _riveController = rive.OneShotAnimation(
//         widget.riveAnimationName ?? 'active',
//         autoplay: false,
//         onStop: () => setState(() => _isActive = false),
//       );
//       debugPrint('Rive animation initialized: ${widget.riveAnimationName}');
//     } catch (e) {
//       debugPrint('Error initializing Rive animation: $e');
//     }
//   }

//   void _handleTap() {
//     setState(() {
//       _isPressed = false;
//       _isActive = true;
//       if (_riveController != null) {
//         _riveController!.isActive = true; // Activate the controller
//       }
//     });
//     widget.onPressed?.call();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _isPressed = true),
//       onTapUp: (_) => _handleTap(),
//       onTapCancel: () => setState(() => _isPressed = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         height: widget.size,
//         width: widget.size,
//         decoration: BoxDecoration(
//           color:
//               widget.isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF0F0F0),
//           shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
//           borderRadius: widget.isCircular ? null : BorderRadius.circular(12),
//           gradient: LinearGradient(
//             begin: _isPressed ? Alignment.bottomRight : Alignment.topLeft,
//             end: _isPressed ? Alignment.topLeft : Alignment.bottomRight,
//             colors: [
//               widget.isDark ? const Color(0xFF1F1F1F) : Colors.white,
//               widget.isDark ? const Color(0xFF3D3D3D) : const Color(0xFFE0E0E0),
//             ],
//           ),
//           boxShadow: _isPressed
//               ? [
//                   // Inner shadow for pressed state
//                   BoxShadow(
//                     color: widget.isDark
//                         ? Colors.black.withOpacity(0.5)
//                         : Colors.white.withOpacity(0.5),
//                     offset: const Offset(-2, -2),
//                     blurRadius: 5,
//                     spreadRadius: -2,
//                   ),
//                   BoxShadow(
//                     color: widget.isDark
//                         ? Colors.black.withOpacity(0.7)
//                         : Colors.grey[400]!.withOpacity(0.7),
//                     offset: const Offset(2, 2),
//                     blurRadius: 5,
//                     spreadRadius: -2,
//                   ),
//                 ]
//               : [
//                   // Reduced outer shadow for unpressed state
//                   BoxShadow(
//                     color: widget.isDark
//                         ? Colors.black.withOpacity(0.3) // Reduced opacity
//                         : Colors.white.withOpacity(0.3), // Reduced opacity
//                     offset: const Offset(-2, -2), // Reduced offset
//                     blurRadius: 4, // Reduced blur radius
//                   ),
//                   BoxShadow(
//                     color: widget.isDark
//                         ? Colors.black.withOpacity(0.4) // Reduced opacity
//                         : Colors.grey[400]!.withOpacity(0.4), // Reduced opacity
//                     offset: const Offset(2, 2), // Reduced offset
//                     blurRadius: 4, // Reduced blur radius
//                   ),
//                 ],
//         ),
//         child: Center(
//           child: _isActive && widget.riveAnimationPath != null
//               ? rive.RiveAnimation.asset(
//                   widget.riveAnimationPath!,
//                   fit: BoxFit.contain,
//                 )
//               : widget.icon != null
//                   ? Icon(
//                       widget.icon,
//                       size: 20,
//                       color: widget.isDark ? Colors.white54 : Colors.black54,
//                     )
//                   : widget.imagePath != null
//                       ? Image.asset(
//                           widget.imagePath!,
//                           width: widget.size * 0.8, // Adjust image size
//                           height: widget.size * 0.8, // Adjust image size
//                           fit: BoxFit.contain,
//                         )
//                       : null,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  final IconData? icon;
  final String? imagePath;
  final VoidCallback? onPressed;
  final bool isDark;
  final bool isCircular;
  final double size;
  final bool isActive;

  const NeumorphicButton({
    super.key,
    this.icon,
    this.imagePath,
    this.onPressed,
    this.isDark = true,
    this.isCircular = true,
    this.size = 45,
    this.isActive = false,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
  }

  void _handleTap() {
    setState(() {
      _isPressed = false;
      _isActive = !_isActive; // Toggle active state
    });
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => _handleTap(),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color:
              widget.isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF0F0F0),
          shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: widget.isCircular ? null : BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: _isPressed ? Alignment.bottomRight : Alignment.topLeft,
            end: _isPressed ? Alignment.topLeft : Alignment.bottomRight,
            colors: [
              widget.isDark ? const Color(0xFF1F1F1F) : Colors.white,
              widget.isDark ? const Color(0xFF3D3D3D) : const Color(0xFFE0E0E0),
            ],
          ),
          boxShadow: _isPressed
              ? [
                  // Inner shadow for pressed state
                  BoxShadow(
                    color: widget.isDark
                        ? Colors.black.withOpacity(0.5)
                        : Colors.white.withOpacity(0.5),
                    offset: const Offset(-2, -2),
                    blurRadius: 5,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: widget.isDark
                        ? Colors.black.withOpacity(0.7)
                        : Colors.grey[400]!.withOpacity(0.7),
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: -2,
                  ),
                ]
              : [
                  // Reduced outer shadow for unpressed state
                  BoxShadow(
                    color: widget.isDark
                        ? Colors.black.withOpacity(0.3) // Reduced opacity
                        : Colors.white.withOpacity(0.3), // Reduced opacity
                    offset: const Offset(-2, -2), // Reduced offset
                    blurRadius: 4, // Reduced blur radius
                  ),
                  BoxShadow(
                    color: widget.isDark
                        ? Colors.black.withOpacity(0.4) // Reduced opacity
                        : Colors.grey[400]!.withOpacity(0.4), // Reduced opacity
                    offset: const Offset(2, 2), // Reduced offset
                    blurRadius: 4, // Reduced blur radius
                  ),
                ],
        ),
        child: Center(
          child: widget.icon != null
              ? Icon(
                  widget.icon,
                  size: 20,
                  color: widget.isDark ? Colors.white54 : Colors.black54,
                )
              : widget.imagePath != null
                  ? Image.asset(
                      widget.imagePath!,
                      width: widget.size * 0.8, // Adjust image size
                      height: widget.size * 0.8, // Adjust image size
                      fit: BoxFit.contain,
                    )
                  : null,
        ),
      ),
    );
  }
}
