import 'package:controller/src/UI/connect/view/connect_hub_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  Future<bool> isConnected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('showOnboarding') ?? true;
  }

  Future<void> neverShowAgain() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showOnboarding', false);
  }

  @override
  Widget build(BuildContext context) {
    final messages = [
      'Download Celmouse HUB for Windows or Mac.',
      'Connect the App to the your computer App.',
    ];

    return FutureBuilder<bool>(
      future: isConnected(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.data == true) {
              return OnBoardingSlider(
                headerBackgroundColor: Colors.transparent,
                finishButtonText: 'Connect',
                pageBackgroundColor: Colors.white,
                controllerColor: Colors.pink,
                finishButtonStyle: const FinishButtonStyle(
                  backgroundColor: Colors.black,
                ),
                onFinish: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConnectHUBPage(),
                  ),
                ),
                background: [
                  Image.asset(
                    'assets/images/onboarding/download.png',
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    'assets/images/onboarding/connect.png',
                    fit: BoxFit.fill,
                  ),
                  // Image.asset('assets/slide_2.png'),
                ],
                centerBackground: true,
                skipTextButton: const Text('Do not show again'),
                skipFunctionOverride: () {
                  neverShowAgain();
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConnectHUBPage(),
                    ),
                  );
                },
                totalPage: messages.length,
                speed: 1.8,
                pageBodies: messages
                    .map(
                      (m) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              m,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(
                              height: 86,
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              );
            } else {
              return const ConnectHUBPage();
            }
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
