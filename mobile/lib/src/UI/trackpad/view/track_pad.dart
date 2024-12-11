import 'package:controller/src/UI/trackpad/viewmodel/trackpad_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackPad extends StatelessWidget {
  final Function(DragUpdateDetails) onDragUpdate;
  final VoidCallback onTwoFingerTap;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final Color baseColor;

  const TrackPad({
    super.key,
    required this.onDragUpdate,
    required this.onTwoFingerTap,
    required this.onTap,
    required this.onDoubleTap,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    final TrackPadViewModel viewModel = TrackPadViewModel();

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Consumer<TrackPadViewModel>(
        builder: (context, viewModel, child) => GestureDetector(
          onScaleStart: (details) {
            viewModel.startDragging(
                details.localFocalPoint.dx, details.localFocalPoint.dy);
          },
          onScaleUpdate: (details) {
            viewModel.updateDragging(
                details.focalPointDelta.dx, details.focalPointDelta.dy);
            onDragUpdate(DragUpdateDetails(
              delta: details.focalPointDelta,
              localPosition: details.localFocalPoint,
              globalPosition: details.focalPoint,
            ));
          },
          onScaleEnd: (details) {
            viewModel.stopDragging();
          },
          onTap: () {
            viewModel.handleTap();
            onTap();
          },
          onDoubleTap: () {
            viewModel.handleDoubleTap();
            onDoubleTap();
          },
          onSecondaryTapDown: (details) {
            viewModel.handleTwoFingerTap();
            onTwoFingerTap();
          },
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: viewModel.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: viewModel.mouseX - 50,
                  top: viewModel.mouseY - 50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: viewModel.dotColor,
                      boxShadow: viewModel.isDragging ||
                              viewModel.isTapped ||
                              viewModel.isDoubleTapped ||
                              viewModel.isTwoFingerTapped
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(5, 5),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-5, -5),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ]
                          : [
                              const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-2, -2),
                                blurRadius: 5,
                              ),
                              BoxShadow(
                                color: Colors.grey[300]!,
                                offset: const Offset(2, 2),
                                blurRadius: 5,
                              ),
                            ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
