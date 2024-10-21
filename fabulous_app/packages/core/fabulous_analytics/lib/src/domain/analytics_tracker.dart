import 'package:flutter/widgets.dart';

abstract interface class AnalyticsTracker {
  Future<void> initialize();

  void trackEvent(String nameEvent, {Map<String, dynamic>? parameters});
  void trackScreen(String nameScreen, {Map<String, dynamic>? parameters});

  void logDebug(String message, {String? tag, Map<String, dynamic>? parameters});
  void logError(dynamic expection, StackTrace stack);

  Future<void> onLogin(String idUser);
  Future<void> onLogout();

  List<NavigatorObserver> get navigatorObservers;
}
