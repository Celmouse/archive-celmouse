import 'package:controller/assets.dart';
import 'package:controller/src/UI/remote_control/widgets/neumorphic_button.dart';
import 'package:controller/src/UI/remote_control/widgets/neumorphic_container.dart';
import 'package:controller/src/UI/remote_control/widgets/neumorphic_vertical_slider.dart';
import 'package:controller/src/UI/remote_control/widgets/neumorphic_text.dart';
import 'package:flutter/material.dart';
import '../viewmodel/remote_viewmodel.dart';

class RemoteView extends StatelessWidget {
  final RemoteViewModel viewmodel;

  const RemoteView({
    super.key,
    required this.viewmodel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          viewmodel.isDark ? const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0),
      body: SafeArea(
        child: Center(
          child: _buildRemoteContent(context),
        ),
      ),
    );
  }

  Widget _buildRemoteContent(BuildContext context) {
    return Center(
      child: NeumorphicContainer(
        borderRadius: 0,
        height: 900,
        width: double.infinity,
        isDark: viewmodel.isDark,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  _buildTopBar(viewmodel),
                  const SizedBox(height: 80),
                  _buildControlSection(viewmodel),
                  const Spacer(),
                  _buildNavigationButtons(viewmodel),
                  const Spacer(),
                  _buildAppShortcuts(viewmodel),
                  const SizedBox(height: 30),
                  _buildBottomNav(viewmodel),
                ],
              ),
              Positioned(
                right: 0,
                top: 70,
                child: VerticalVolumeSlider(
                  isDark: viewmodel.isDark,
                  onVolumeChanged: (volume) {
                    // viewmodel.adjustVolume(volume);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(RemoteViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NeumorphicButton(
          icon: Icons.power_settings_new,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('power'),
        ),
        NeumorphicText(
          'Celmouse',
          isDark: viewModel.isDark,
        ),
        NeumorphicButton(
          icon: Icons.screenshot_monitor,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('screenshot'),
        ),
      ],
    );
  }

  Widget _buildControlSection(RemoteViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDirectionalPad(viewModel),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionalPad(RemoteViewModel viewModel) {
    return SizedBox(
      height: 160,
      width: 160,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: viewModel.isDark ? Colors.white12 : Colors.black12,
                  width: 2,
                ),
              ),
            ),
          ),
          // Top button
          Align(
            alignment: const Alignment(
              0,
              -1.2,
            ),
            child: _buildDirectionalButton(
              icon: Icons.keyboard_arrow_up,
              onPressed: () => viewModel.sendDirectionalCommand('up'),
            ),
          ),
          // Bottom button
          Align(
            alignment: const Alignment(
              0,
              1.2,
            ),
            child: _buildDirectionalButton(
              icon: Icons.keyboard_arrow_down,
              onPressed: () => viewModel.sendDirectionalCommand('down'),
            ),
          ),
          // Left button
          Align(
            alignment: const Alignment(
              -1.2,
              0,
            ),
            child: _buildDirectionalButton(
              icon: Icons.keyboard_arrow_left,
              onPressed: () => viewModel.sendDirectionalCommand('left'),
            ),
          ),
          // Right button
          Align(
            alignment: const Alignment(
              1.2,
              0,
            ),
            child: _buildDirectionalButton(
              icon: Icons.keyboard_arrow_right,
              onPressed: () => viewModel.sendDirectionalCommand('right'),
            ),
          ),
          // Center button
          Center(
            child: NeumorphicButton(
              isDark: viewModel.isDark,
              onPressed: () => viewModel.sendDirectionalCommand('ok'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionalButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return NeumorphicButton(
      icon: icon,
      isDark: true,
      onPressed: onPressed,
    );
  }

  Widget _buildNavigationButtons(RemoteViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeumorphicButton(
          icon: Icons.home,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('home'),
        ),
        NeumorphicButton(
          icon: Icons.refresh,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('refresh'),
        ),
        NeumorphicButton(
          icon: Icons.menu,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('menu'),
        ),
      ],
    );
  }

  Widget _buildAppShortcuts(RemoteViewModel viewModel) {
    final apps = [
      {'name': 'Netflix', 'imagePath': Assets.netflix},
      {'name': 'Prime', 'imagePath': Assets.prime},
      {'name': 'Disney+', 'imagePath': Assets.disneyPlus},
      {
        'name': 'Spotify',
        'imagePath': Assets.spotify,
        'riveAnimationPath': Assets.spotifyRiv,
      },
      {'name': 'YouTube', 'imagePath': Assets.youtube},
      {'name': 'BBC News', 'imagePath': Assets.bbcNews},
      {
        'name': 'Google',
        'imagePath': Assets.google,
      },
      {'name': 'Play Store', 'imagePath': Assets.googlePlayStore},
    ];

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 4,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: apps.map((app) => _buildAppButton(app, viewModel)).toList(),
    );
  }

  Widget _buildAppButton(Map<String, String> app, RemoteViewModel viewModel) {
    return NeumorphicButton(
      isDark: viewModel.isDark,
      isCircular: false,
      onPressed: () => viewModel.launchApp(app['name']!),
      imagePath: app['imagePath']!,
      // riveAnimationPath: app['riveAnimationPath'],
      isActive: viewModel.activeApp == app['name'],
    );
  }

  Widget _buildBottomNav(RemoteViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        NeumorphicButton(
          icon: Icons.share,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('red'),
        ),
        NeumorphicButton(
          icon: Icons.grid_view,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('green'),
        ),
        NeumorphicButton(
          /// express writing with keyboard
          icon: Icons.keyboard,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('yellow'),
        ),
        NeumorphicButton(
          icon: Icons.copy,
          isDark: viewModel.isDark,
          onPressed: () => viewModel.sendCommand('blue'),
        ),
      ],
    );
  }
}
