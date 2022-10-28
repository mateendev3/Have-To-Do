import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/task.dart';
import '../home/controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: ListView(
          children: [
            _buildTitle(),
            _buildProgressIndicator(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.grey),
    );
  }

  Widget _buildTitle() {
    Task task = _homeController.task.value!;
    return ListTile(
      leading: Icon(
        IconData(task.icon, fontFamily: 'MaterialIcons'),
        color: HexColor.fromHex(task.color),
      ),
      horizontalTitleGap: 0.0,
      title: Text(
        task.title,
        style: TextStyle(
          fontSize: 18.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    _homeController.changeTask(null);
    return true;
  }

  Widget _buildProgressIndicator() {
    int totalTodos = _homeController.completedTodos.length +
        _homeController.uncompletedTodos.length;

    Task task = _homeController.task.value!;
    Color color = HexColor.fromHex(task.color);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListTile(
        leading: Text(
          '$totalTodos Tasks',
          style: TextStyle(
            fontSize: 12.0.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        title: StepProgressIndicator(
          totalSteps: totalTodos == 0 ? 1 : totalTodos,
          currentStep: _homeController.completedTodos.length,
          size: 6.0,
          padding: 0.0,
          selectedGradientColor: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [HexColor.fromHex(task.color).withOpacity(0.5), color],
          ),
          unselectedGradientColor: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.grey.shade300, Colors.grey.shade300],
          ),
        ),
      ),
    );
  }
}
