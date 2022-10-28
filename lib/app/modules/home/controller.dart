import 'package:flutter/foundation.dart';
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
  final Rx<Task?> task = Rx<Task?>(null); // obs

  final RxList<dynamic> uncompletedTodos = <dynamic>[].obs;
  final RxList<dynamic> completedTodos = <dynamic>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController todoTitleController;

  // Life cycles methods
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

  // changing obs
  void changeChipIndex(int index) => chipIndex.value = index;
  void changeDeleting(bool deleting) => isDeleting.value = deleting;
  void changeTask(Task? selectedTask) => task.value = selectedTask;

  //* Task Type
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

  // update task from tasks list
  bool updateTask(Task task, String title) {
    List<dynamic> todos = task.todos ?? [];

    // checking weather the todo with this title exists or not
    if (containTodo(todos, title)) return false;

    // adding new todo to the list
    final newTodo = {'title': title, 'done': false};
    todos.add(newTodo);

    // updating task
    Task updatedTask = task.copyWith(todos: todos);

    // getting the index of previous task in the tasks list
    int oldTaskIndex = tasks.indexOf(task);

    // updating new task with old one
    tasks[oldTaskIndex] = updatedTask;

    tasks.refresh();
    return true;
  }

  // checking weather the todo with this title exists or not
  bool containTodo(List<dynamic> todos, String title) {
    return todos.any((todoMap) => todoMap['title'] == title);
  }

  // updating done or un-done todos to specific task
  void updateTaskTodos() {
    final newTodos = <Map<String, dynamic>>[];
    newTodos.addAll(
      [
        ...uncompletedTodos,
        ...completedTodos,
      ],
    );
    Task newTask = task.value!.copyWith(todos: newTodos);
    int oldTaskIndex = tasks.indexOf(task.value);
    tasks[oldTaskIndex] = newTask;
    tasks.refresh();
  }

  //* Todos
  // changing todos dynamically for showing completed or un-completed
  void changeTodos(List<dynamic> selectedTaskTodos) {
    completedTodos.clear();
    uncompletedTodos.clear();
    for (var todo in selectedTaskTodos) {
      bool status = todo['done'];
      if (status) {
        completedTodos.add(todo);
      } else {
        uncompletedTodos.add(todo);
      }
    }
  }

  // adding todo to uncompletedTodo list
  bool addTodo(String todoTitle) {
    // checking if todo is already available in uncompleted todos
    final uncompletedTodo = {'title': todoTitle, 'done': false};
    if (uncompletedTodos.any(
      (unCompletedTodo) => mapEquals<String, dynamic>(
        uncompletedTodo,
        unCompletedTodo,
      ),
    )) {
      print(false);
      return false;
    }

    // checking if todo is already available in completed todos
    final completedTodo = {'title': todoTitle, 'done': true};
    if (completedTodos.any(
      (doneTodo) => mapEquals<String, dynamic>(
        completedTodo,
        doneTodo,
      ),
    )) {
      print(false);

      return false;
    }

    // adding todo to uncompleted todos
    uncompletedTodos.add(uncompletedTodo);
    print(true);

    return true;
  }
}
