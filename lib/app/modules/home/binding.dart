import 'package:get/get.dart';
import 'package:have_to_do/app/data/providers/task/provider.dart';
import 'package:have_to_do/app/data/services/storage/repository.dart';
import 'package:have_to_do/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // injecting home controller
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
