import 'package:controller/getit.dart';
import 'package:controller/src/services/mouse_settings_persistence.dart';
import 'mouse_settings.dart';

class GlobalConfigs {
  Future<void> init() async {
    await _initMouse();
    // Inicializa outras coisas
  }

  _initMouse() async {
    final MouseSettingsPersistence settings = MouseSettingsPersistence();

    if (getIt.isRegistered<MouseSettings>()) {
      await getIt.unregister();
    }
    getIt.registerSingleton<MouseSettings>(await settings.loadSettings());
  }
}
