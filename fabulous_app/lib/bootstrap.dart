import 'package:flutter/material.dart';

import 'config/environment_config.dart';
import 'modules.dart';

Future<void> bootstrap(EnvironmentConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  // getIt.registerSingleton<EnvironmentConfig>(config);

  for (final module in appModules) {
    await module.injectDependencies(config);
  }
  for (final module in appModules) {
    await module.bootstrap(config);
  }
}
