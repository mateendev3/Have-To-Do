import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../../../core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  final StorageService _service = Get.find<StorageService>();

  List<Task> readTasks() {
    log('## readTask provider');
    // ignore: todo
    // TODO: jsonDecode
    return ((jsonDecode(_service.read(keyTasks))) as List<dynamic>)
        .map((taskMap) => Task.fromMap(taskMap))
        .toList();
  }

  void writeTasks(List<Task> tasks) {
    _service.write(keyTasks, tasks);
  }
}
