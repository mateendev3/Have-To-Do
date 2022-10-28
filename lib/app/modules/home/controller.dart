import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/task.dart';
import '../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  HomeController({
    required TaskRepository taskRepository,
  }) : _tasksRepository = taskRepository;

  final TaskRepository _tasksRepository;

  // observe-able variable
  final RxList<Task> tasks = <Task>[].obs;
  final RxInt chipIndex = 0.obs;
  final RxBool isDeleting = false.obs;
  final Rx<Task?> task = Rx<Task?>(null); // obs //Todo: prob

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController todoTitleController;

  @override
  void onInit() {
    super.onInit();
    // called every time when tasks changes
    ever(tasks, (tasks) => _tasksRepository.writeTasks(tasks));
    todoTitleController = TextEditingController();
  }

  @override
  void onClose() {
    todoTitleController.dispose();
    super.onClose();
  }

  void changeChipIndex(int index) => chipIndex.value = index;
  void changeDeleting(bool deleting) => isDeleting.value = deleting;
  void changeTask(Task? selectedTask) => task.value = selectedTask;

  // add task to tasks list
  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }

    tasks.add(task);
    return true;
  }

  // delete task from tasks list
  void deleteTask(Task task) {
    tasks.remove(task);
  }
}
