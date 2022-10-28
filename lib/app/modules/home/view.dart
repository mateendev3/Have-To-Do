import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:have_to_do/app/modules/home/widgets/add_dialog.dart';
import '../../core/values/colors.dart';
import '../../data/models/task.dart';
import 'controller.dart';
import 'widgets/add_card.dart';
import 'widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          _buildTitle(),
          _buildTodos(),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Text(
        'My List',
        style: TextStyle(
          fontSize: 24.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTodos() {
    return Obx(
      () {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            ...controller.tasks.map(
              (task) {
                return LongPressDraggable<Task>(
                  data: task,
                  onDragStarted: () => controller.changeDeleting(true),
                  onDraggableCanceled: (_, __) =>
                      controller.changeDeleting(false),
                  onDragEnd: (_) => controller.changeDeleting(false),
                  feedback: Opacity(
                    opacity: 0.8,
                    child: TaskCard(task: task),
                  ),
                  child: TaskCard(task: task),
                );
              },
            ).toList(),
            AddCard(),
          ],
        );
      },
    );
  }

  Widget _buildFAB() {
    return DragTarget<Task>(
      onAccept: (Task task) {
        controller.deleteTask(task);
        EasyLoading.showSuccess('Task Deleted');
      },
      builder: (_, __, ___) {
        return Obx(
          () => FloatingActionButton(
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(
                  () => AddDialog(),
                  fullscreenDialog: true,
                  transition: Transition.rightToLeft,
                );
              } else {
                EasyLoading.showInfo('Please create your task type');
              }
            },
            backgroundColor: controller.isDeleting.value ? Colors.red : blue,
            child: Icon(controller.isDeleting.value ? Icons.delete : Icons.add),
          ),
        );
      },
    );
  }
}
