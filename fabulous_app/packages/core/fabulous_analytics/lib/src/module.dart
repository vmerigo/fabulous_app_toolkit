import 'package:fabulous_core/fabulous_core.dart';

import 'config.dart';

const analyticsModule = FabulousModule<FabulousAnalyticsConfig>(
  name: 'fabulous_analytics',
  injectDependencies: _injectDependencies,
  bootstrap: _bootstrap,
  cleanup: _cleanup,
);

Future<void> _injectDependencies(FabulousAnalyticsConfig config) async {}
Future<void> _bootstrap(FabulousAnalyticsConfig config) async {}
Future<void> _cleanup() async {}
