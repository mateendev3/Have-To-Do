import '../../models/task.dart';
import '../../providers/task/provider.dart';

class TaskRepository {
  TaskRepository({
    required TaskProvider taskProvider,
  }) : _taskProvider = taskProvider;

  final TaskProvider _taskProvider;

  List<Task> readTasks() => _taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => _taskProvider.writeTasks(tasks);
}
