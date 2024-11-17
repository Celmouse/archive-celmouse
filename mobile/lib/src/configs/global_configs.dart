import 'package:controller/getit.dart';
import 'package:controller/src/features/mouse/move/data/mouse_settings_persistence.dart';
import '../features/mouse/move/data/mouse_settings_model.dart';

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
