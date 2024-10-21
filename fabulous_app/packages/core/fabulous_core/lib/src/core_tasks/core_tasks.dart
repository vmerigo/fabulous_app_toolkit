import 'dart:async';

final class CoreTasks {
  CoreTasks._();

  static final _hasRunningTaskStreamController = StreamController<bool>();
  static final hasRunningTasksStream = _hasRunningTaskStreamController.stream.asBroadcastStream();

  static int get runningTasks => _runningTasks;
  static bool get hasRunningTasks => runningTasks > 0;

  static int _runningTasks = 0;

  static Future<R> run<R>(
    FutureOr<R> Function() computation,
  ) async {
    _incrementRunningTasks();
    try {
      return await computation();
    } catch (_) {
      rethrow;
    } finally {
      _decrementRunningTasks();
    }
  }

  static void _incrementRunningTasks() {
    _runningTasks++;
    _hasRunningTaskStreamController.add(hasRunningTasks);
  }

  static void _decrementRunningTasks() {
    _runningTasks--;
    _hasRunningTaskStreamController.add(hasRunningTasks);
  }
}
