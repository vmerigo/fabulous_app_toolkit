typedef DependencyInjector<Config> = Future<void> Function(Config env);
typedef BootstrapFunction<Config> = Future<void> Function(Config env);
typedef CleanupCallback = Future<void> Function();
typedef ConfigAdapter<TargetConfig, Config> = Config Function(TargetConfig targetConfig);

final class FabulousModule<Config> {
  const FabulousModule({
    required this.name,
    required this.injectDependencies,
    required this.bootstrap,
    this.cleanup,
  });

  final String name;
  final DependencyInjector<Config> injectDependencies;
  final BootstrapFunction<Config> bootstrap;
  final CleanupCallback? cleanup;

  FabulousModule<TargetConfig> adaptConfig<TargetConfig>(
    ConfigAdapter<TargetConfig, Config> adapter,
  ) {
    Future<void> injectDependencies(TargetConfig toConfig) => this.injectDependencies(
          adapter(toConfig),
        );

    Future<void> bootstrap(TargetConfig toConfig) => this.bootstrap(
          adapter(toConfig),
        );

    return FabulousModule<TargetConfig>(
      name: name,
      injectDependencies: injectDependencies,
      bootstrap: bootstrap,
      cleanup: cleanup,
    );
  }
}
