import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/controller.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Details'),
    );
  }
}
