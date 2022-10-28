import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:have_to_do/app/modules/detail/widgets/completed_todo_list.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../core/utils/extensions.dart';
import '../../data/models/task.dart';
import '../home/controller.dart';
import 'widgets/uncompleted_todo_list.dart';

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
            _buildAddTodoTextField(),
            UncompletedTodoList(),
            if (_homeController.uncompletedTodos.isNotEmpty) _buildDivider(),
            CompletedTodoList(),
          ],
        ),
      ),
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Divider(
        color: Colors.grey,
        height: 3.0.w,
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
    _homeController.updateTaskTodos();
    _homeController.changeTask(null);
    _homeController.todoTitleController.clear();
    return true;
  }

  Widget _buildProgressIndicator() {
    Task task = _homeController.task.value!;
    Color color = HexColor.fromHex(task.color);

    return Obx(
      () {
        int totalTodos = _homeController.completedTodos.length +
            _homeController.uncompletedTodos.length;
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
      },
    );
  }

  Widget _buildAddTodoTextField() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Form(
        key: _homeController.formKey,
        child: TextFormField(
          controller: _homeController.todoTitleController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            hintText: 'Todo Here',
            prefixIcon: Icon(
              Icons.check_box_outline_blank,
              color: Colors.grey.shade400,
            ),
            suffixIcon: IconButton(
              onPressed: onCheckIconButtonTap,
              icon: Icon(
                Icons.check,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your task title';
            }
            return null;
          },
        ),
      ),
    );
  }

  void onCheckIconButtonTap() {
    if (_homeController.formKey.currentState!.validate()) {
      bool hasAdded =
          _homeController.addTodo(_homeController.todoTitleController.text);

      hasAdded
          ? EasyLoading.showSuccess('Todo added')
          : EasyLoading.showError('Todo already exists');

      _homeController.todoTitleController.clear();
    }
  }
}
