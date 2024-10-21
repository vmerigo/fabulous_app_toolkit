import 'package:flutter/widgets.dart';

import 'analytics_tracker.dart';

abstract class AnalyticsService implements AnalyticsTracker {
  List<AnalyticsTracker> get trackers;

  @override
  Future<void> initialize() {
    return Future.wait(
      trackers.map(
        (tracker) => tracker.initialize(),
      ),
    );
  }

  @override
  void logDebug(String message, {String? tag, Map<String, dynamic>? parameters}) {
    for (final tracker in trackers) {
      tracker.logDebug(message, tag: tag, parameters: parameters);
    }
  }

  @override
  void trackEvent(String nameEvent, {Map<String, dynamic>? parameters}) {
    for (final tracker in trackers) {
      tracker.trackEvent(nameEvent, parameters: parameters);
    }
  }

  @override
  void logError(dynamic expection, StackTrace stack) {
    for (final tracker in trackers) {
      tracker.logError(expection, stack);
    }
  }

  @override
  Future<void> onLogin(String idUser) {
    return Future.wait(
      trackers.map(
        (tracker) => tracker.onLogin(idUser),
      ),
    );
  }

  @override
  Future<void> onLogout() {
    return Future.wait(
      trackers.map(
        (tracker) => tracker.onLogout(),
      ),
    );
  }

  @override
  List<NavigatorObserver> get navigatorObservers => trackers
      .expand(
        (tracker) => tracker.navigatorObservers,
      )
      .toList();
}
