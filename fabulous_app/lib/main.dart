import 'package:flutter/material.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'config/develop_environment_config.dart';

void main() async {
  await bootstrap(DevelopEnvironmentConfig());
  runApp(const MainApp());
}
