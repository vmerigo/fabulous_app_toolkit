import 'package:fabulous_core/fabulous_core.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestEnvironmentConfig {
  _TestEnvironmentConfig({
    required this.moduleConfig,
  });

  final _ModuleConfig moduleConfig;
}

class _ModuleConfig {
  _ModuleConfig(this.apikey);
  final String apikey;
}

void main() {
  group('FabulousModule', () {
    late FabulousModule<_ModuleConfig> module;
    late int bootstrapCallCount;
    late int injectDepsCount;
    const testApikey = 'apikey';
    final envConfig = _TestEnvironmentConfig(
      moduleConfig: _ModuleConfig(testApikey),
    );

    var apiKeyConfigurated = '';

    setUp(() {
      bootstrapCallCount = 0;
      injectDepsCount = 0;
      module = FabulousModule<_ModuleConfig>(
        name: 'TestModule',
        bootstrap: (final env) async {
          bootstrapCallCount += 1;
          apiKeyConfigurated = env.apikey;
        },
        injectDependencies: (final env) async {
          injectDepsCount += 1;
        },
      );
    });

    test('initialize should call dependenciesInjection and bootstrap', () async {
      await module.injectDependencies(envConfig.moduleConfig);
      await module.bootstrap(envConfig.moduleConfig);

      expect(injectDepsCount, equals(1));
      expect(bootstrapCallCount, equals(1));
      expect(apiKeyConfigurated, equals(testApikey));
    });

    test('adaptConfig should return a new module with adapted config', () async {
      final moduleAdapted = module.adaptConfig<_TestEnvironmentConfig>(
        (final config) => config.moduleConfig,
      );

      await moduleAdapted.injectDependencies(envConfig);
      await moduleAdapted.bootstrap(envConfig);

      expect(injectDepsCount, equals(1));
      expect(bootstrapCallCount, equals(1));
      expect(apiKeyConfigurated, equals(testApikey));
    });
  });
}
