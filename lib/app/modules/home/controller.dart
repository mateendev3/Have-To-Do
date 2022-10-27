import 'package:get/get.dart';
import '../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  HomeController({
    required TaskRepository taskRepository,
  }) : _tasksRepository = taskRepository;

  final TaskRepository _tasksRepository;
}
