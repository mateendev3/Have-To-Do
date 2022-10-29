import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/task.dart';
import '../../detail/view.dart';
import '../controller.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    Key? key,
    required Task task,
  })  : _task = task,
        super(key: key);

  final HomeController _homeController = Get.find<HomeController>();
  final Task _task;

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(_task.color);
    return _buildBody(color);
  }

  Widget _buildBody(Color color) {
    return GestureDetector(
      onTap: () {
        _homeController.task.value = _task;
        _homeController.changeTodos(_task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: 1.0.sw / 2,
        height: 1.0.sw / 2,
        margin: EdgeInsets.all(8.0.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 7.0,
              offset: const Offset(0, 7.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepProgressIndicator(),
            _buildIcon(color),
            const Expanded(child: SizedBox()),
            _buildTitleAndTotalTasksText(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepProgressIndicator() {
    final color = HexColor.fromHex(_task.color);
    return StepProgressIndicator(
      totalSteps:
          _homeController.isTaskTodosEmpty(_task) ? 1 : _task.todos!.length,
      currentStep: _homeController.isTaskTodosEmpty(_task)
          ? 0
          : _homeController.getDoneTodosNumber(_task),
      size: 5.0,
      padding: 0.0,
      selectedGradientColor: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [color.withOpacity(0.5), color],
      ),
      unselectedGradientColor: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.white, Colors.white],
      ),
    );
  }

  Widget _buildIcon(Color color) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Icon(
        IconData(
          _task.icon,
          fontFamily: 'MaterialIcons',
        ),
        color: color,
      ),
    );
  }

  Widget _buildTitleAndTotalTasksText() {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _task.title,
            style: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.0.w),
          Text(
            '${_task.todos?.length ?? 0} Tasks',
            style: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
