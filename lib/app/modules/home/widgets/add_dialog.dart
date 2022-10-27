import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({Key? key}) : super(key: key);

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildTitle(),
          _buildTitleTextField(),
        ],
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
          onPressed: () {},
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
    );
  }
}
