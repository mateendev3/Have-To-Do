import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../home/controller.dart';

class UncompletedTodoList extends StatelessWidget {
  UncompletedTodoList({Key? key}) : super(key: key);

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _homeController.uncompletedTodos.isEmpty &&
              _homeController.completedTodos.isEmpty
          ? _buildNoTodosImageAndTitle()
          : _buildUncompletedTodoListItems(),
    );
  }

  Widget _buildUncompletedTodoListItems() {
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      children: [
        ..._homeController.uncompletedTodos.map((uncompletedTodo) {
          return CheckboxListTile(
            value: false,
            onChanged: (value) {
              _homeController.doneTodo(uncompletedTodo['title']);
            },
            checkColor: Colors.grey,
            title: Text(uncompletedTodo['title']),
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),
        Obx(
          () => _homeController.uncompletedTodos.isNotEmpty
              ? _buildDivider()
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildNoTodosImageAndTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 24.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_no_todo.png',
              fit: BoxFit.cover,
              width: 0.5.sw,
            ),
            SizedBox(height: 16.0.w),
            Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Divider(
        color: Colors.grey,
        height: 3.0.w,
      ),
    );
  }
}
