import 'package:flutter/widgets.dart';

import 'core_tasks.dart';

///Render child only when there are running tasks
class CoreTaskBuilder extends StatelessWidget {
  const CoreTaskBuilder({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CoreTasks.hasRunningTasksStream,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return child;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
