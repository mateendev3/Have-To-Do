import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
}
