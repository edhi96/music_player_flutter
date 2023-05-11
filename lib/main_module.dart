import 'package:equatable/equatable.dart';

import 'features/home/home_module.dart';

class MainModule {
  static Future<void> init() async {
    EquatableConfig.stringify = true;
    await loadModules();
  }

  static Future<void> loadModules() async {
    HomeModule.init();
  }
}
