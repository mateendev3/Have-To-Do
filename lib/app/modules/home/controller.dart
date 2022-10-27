import 'package:get/get.dart';
import 'package:have_to_do/app/data/models/task.dart';
import '../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  HomeController({
    required TaskRepository taskRepository,
  }) : _tasksRepository = taskRepository;

  final TaskRepository _tasksRepository;
  // observe-able variable
  final RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    // called every time when tasks changes
    ever(tasks, (tasks) => _tasksRepository.writeTasks(tasks));
  }
}
