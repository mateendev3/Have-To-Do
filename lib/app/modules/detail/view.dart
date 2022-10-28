import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.grey),
    );
  }
}
