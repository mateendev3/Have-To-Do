import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/values/colors.dart';
import '../../../data/models/task.dart';
import '../controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({Key? key}) : super(key: key);

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
            _buildTitleTextField(),
            _buildAddToSubTitle(),
            ..._buildTaskTypeItems(),
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
      actions: [
        TextButton(
          onPressed: onDoneButtonPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            'Done',
            style: TextStyle(fontSize: 14.0.sp, color: blue),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Text(
        'New Task',
        style: TextStyle(
          fontSize: 18.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Form(
        key: _homeController.formKey,
        child: TextFormField(
          controller: _homeController.todoTitleController,
          autofocus: true,
          decoration: InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            hintText: 'Title here',
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

  Widget _buildAddToSubTitle() {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.0.w,
        left: 8.0.w,
        right: 8.0.w,
        bottom: 8.0.w,
      ),
      child: Text(
        'Add To',
        style: TextStyle(
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }

  List<Widget> _buildTaskTypeItems() {
    return [
      ..._homeController.tasks
          .map(
            (Task task) => Obx(
              () {
                return ListTile(
                  title: Text(task.title),
                  onTap: () => _homeController.changeTask(task),
                  leading: Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: HexColor.fromHex(task.color),
                  ),
                  trailing: _homeController.task.value == task
                      ? const Icon(Icons.check, color: Colors.blue)
                      : const SizedBox(),
                );
              },
            ),
          )
          .toList(),
    ];
  }

  Future<bool> onWillPop() async {
    _homeController.todoTitleController.clear();
    _homeController.changeTask(null);
    return true;
  }

  void onDoneButtonPressed() {
    if (_homeController.formKey.currentState!.validate()) {
      if (_homeController.task.value == null) {
        EasyLoading.showError('Please select task type');
      } else {
        bool isSuccessfullyAdded = _homeController.updateTask(
          _homeController.task.value!,
          _homeController.todoTitleController.text,
        );

        if (isSuccessfullyAdded) {
          EasyLoading.showSuccess('Todo added');
          Get.back();
          _homeController.changeTask(null);
        } else {
          EasyLoading.showError('Todo already exist');
        }

        _homeController.todoTitleController.clear();
      }
    }
  }
}
