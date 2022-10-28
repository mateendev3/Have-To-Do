import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../core/utils/extensions.dart';
import '../../../data/models/task.dart';
import '../../../widgets/icons.dart';
import '../controller.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});
  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw / 2,
      height: 1.sw / 2,
      margin: EdgeInsets.all(8.0.w),
      child: InkWell(
        onTap: () async {
          await showCreateTodoDialog();
          _homeController.todoTitleController.clear();
          _homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey.shade400,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 24.0.sp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showCreateTodoDialog() async {
    await Get.defaultDialog(
      title: 'Task Type',
      titlePadding: EdgeInsets.symmetric(vertical: 8.0.w),
      radius: 4.0.r,
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.all(4.0.w),
        child: Form(
          key: _homeController.formKey,
          child: Column(
            children: [
              _buildTitleTextField(),
              _buildChoiceChipList(),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: TextFormField(
        controller: _homeController.todoTitleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter your task title';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildChoiceChipList() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Wrap(
        spacing: 8.0.w,
        children: getIcons()
            .map(
              (icon) => Obx(
                () {
                  final int index = getIcons().indexOf(icon);
                  return ChoiceChip(
                    label: icon,
                    selectedColor: Colors.grey.shade200,
                    pressElevation: 0.0,
                    backgroundColor: Colors.white,
                    selected: _homeController.chipIndex.value == index,
                    onSelected: (bool selected) =>
                        _homeController.chipIndex.value = selected ? index : 0,
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: onDialogConfirmButtonPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
        minimumSize: const Size(160.0, 40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0.r),
        ),
      ),
      child: const Text('Confirm'),
    );
  }

  void onDialogConfirmButtonPress() {
    if (_homeController.formKey.currentState!.validate()) {
      int icon =
          getIcons().elementAt(_homeController.chipIndex.value).icon!.codePoint;
      String color =
          getIcons().elementAt(_homeController.chipIndex.value).color!.toHex();
      String title = _homeController.todoTitleController.text;

      // creating task
      Task task = Task(title: title, icon: icon, color: color);

      // poping back
      Get.back();

      // showing status (success or error)
      _homeController.addTask(task)
          ? EasyLoading.showSuccess('Task Created')
          : EasyLoading.showError('Duplicated Task');
    }
  }
}
