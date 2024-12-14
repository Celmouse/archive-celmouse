import 'dart:io';

import 'package:controller/getit.dart';
import 'package:controller/src/UI/trackpad/trackpad_page.dart';
import 'package:controller/src/data/services/lifecycle_service.dart';
import 'package:controller/src/config/consent_manager.dart';
import 'package:controller/src/config/enviroment.dart';
import 'package:controller/src/ui/keyboard/view/keyboard.dart';
import 'package:controller/src/ui/keyboard/viewmodel/keyboard_view_model.dart';
import 'package:controller/src/ui/mouse_move/view/mouse_move_body.dart';
import 'package:controller/src/ui/mouse_move/view/mouse_move_settings_page.dart';
import 'package:controller/src/ui/mouse/viewmodel/mouse_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/mouse_settings_model.dart';
import '../../../data/services/mouse_settings_persistence_service.dart';
import '../../mouse_move/view/components/mouse_mode_switch.dart';
import 'package:controller/src/data/repositories/connection_repository.dart';

class MousePage extends StatefulWidget {
  const MousePage({
    super.key,
    required this.viewmodel,
  });

  final MouseViewmodel viewmodel;

  @override
  State<MousePage> createState() => _MousePageState();
}

enum CursorKeysPressed {
  none,
  leftClick,
  rightClick,
}

class _MousePageState extends State<MousePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  late ConnectionRepository _connectionRepository;
  late LifecycleService _lifecycleService;
  final _consentManager = ConsentManager();
  var _isMobileAdsInitializeCalled = false;
  var _isPrivacyOptionsRequired = false;
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _connectionRepository =
        Provider.of<ConnectionRepository>(context, listen: false);
    _lifecycleService = LifecycleService(
      connectionRepository: _connectionRepository,
      mouseViewmodel: widget.viewmodel,
    );

    MouseSettingsPersistenceService.loadSettings().then((settings) {
      getIt.registerSingleton<MouseSettings>(settings);
    });

    _consentManager.gatherConsent((consentGatheringError) {
      // Check if a privacy options entry point is required.
      _getIsPrivacyOptionsRequired();

      // Attempt to initialize the Mobile Ads SDK.
      _initializeMobileAdsSDK();
    });

    // This sample attempts to load ads using consent obtained in the previous session.
    _initializeMobileAdsSDK();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    widget.viewmodel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onToggle(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    widget.viewmodel.disableMouse();
    _pageController.jumpToPage(index);
  }

  Widget get _drawer {
    if (_currentPageIndex == 0) {
      return const CursorSettingsPage();
    }
    return Container(
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: _drawer,
      onEndDrawerChanged: (isOpened) {
        if (!isOpened) {
          MouseSettingsPersistenceService.saveSettings(getIt<MouseSettings>());
        } else {
          widget.viewmodel.disableMouse();
        }
      },
      appBar: AppBar(
        title: const Text('Mouse'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          const Visibility(
            visible: kDebugMode,
            child: IconButton(
              onPressed: null, //isMicOn ? disableVoiceType : enableVoiceType,
              icon: Icon(
                Icons.mic,
                color: null, // isMicOn ? Colors.greenAccent : null,
              ),
            ),
          ),
          Visibility(
            visible: kDebugMode,
            child: ListenableBuilder(
                listenable: widget.viewmodel,
                builder: (context, _) {
                  return IconButton(
                    onPressed: () {
                      widget.viewmodel.disableMouse();
                      if (widget.viewmodel.keyboardOpenClose()) {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: size.height * 0.4,
                              child: KeyboardTyppingPage(
                                viewmodel: KeyboardViewModel(
                                  keyboardRepository: context.read(),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(
                      widget.viewmodel.isKeyboardOpen
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard,
                    ),
                  );
                }),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: kDebugMode,
              child: MouseModeSwitch(
                onToggle: _onToggle,
                currentIndex: _currentPageIndex,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: [
                  const MoveMouseBody(),
                  const TrackpadPage(),
                  _buildDragPage(size),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            if (_bannerAd != null && _isLoaded)
              SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragPage(Size size) {
    return const Center(
      child: Hero(
        tag: 'mouse-mode-switch',
        child: Text('Drag Page'),
      ),
    );
  }

  /// Loads and shows a banner ad.
  ///
  /// Dimensions of the ad are determined by the width of the screen.
  void _loadAd() async {
    // Only load an ad if the Mobile Ads SDK has gathered consent aligned with
    // the app's configured messages.
    var canRequestAds = await _consentManager.canRequestAds();
    if (!canRequestAds) {
      return;
    }

    if (!mounted) {
      return;
    }

    final String _adUnitId = Platform.isAndroid
        ? EnviromentVariables.admobBannerIdAndroid
        : EnviromentVariables.admobBannerId;

    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.sizeOf(context).width.truncate());

    if (size == null) {
      // Unable to get width of anchored banner.
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  /// Redraw the app bar actions if a privacy options entry point is required.
  void _getIsPrivacyOptionsRequired() async {
    if (await _consentManager.isPrivacyOptionsRequired()) {
      setState(() {
        _isPrivacyOptionsRequired = true;
      });
    }
  }

  /// Initialize the Mobile Ads SDK if the SDK has gathered consent aligned with
  /// the app's configured messages.
  void _initializeMobileAdsSDK() async {
    if (_isMobileAdsInitializeCalled) {
      return;
    }

    if (await _consentManager.canRequestAds()) {
      _isMobileAdsInitializeCalled = true;

      // Initialize the Mobile Ads SDK.
      MobileAds.instance.initialize();

      // Load an ad.
      _loadAd();
    }
  }
}
