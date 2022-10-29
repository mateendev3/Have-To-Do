import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:have_to_do/app/core/values/colors.dart';
import '../../home/controller.dart';

class CompletedTodoList extends StatelessWidget {
  CompletedTodoList({Key? key}) : super(key: key);

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Obx(
      () => _homeController.completedTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                _buildCompletedTitle(),
                ..._buildCompletedTodoListItems(),
              ],
            )
          : const SizedBox(),
    );
  }

  List<Widget> _buildCompletedTodoListItems() {
    return _homeController.completedTodos.map(
      (completedTodo) {
        return Dismissible(
          key: ObjectKey(completedTodo),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) =>
              _homeController.deletedDoneTodo(completedTodo['title']),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: ListTile(
              leading: const Icon(
                Icons.check,
                color: blue,
              ),
              horizontalTitleGap: 0.0,
              title: Text(
                completedTodo['title'],
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ),
        );
      },
    ).toList();
  }

  Widget _buildCompletedTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Text(
        'Completed (${_homeController.completedTodos.length})',
        style: TextStyle(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
