import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return Obx(() {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...controller.tasks.map((task) => TaskCard(task: task)).toList(),
          AddCard(),
        ],
      );
    });
  }
}
