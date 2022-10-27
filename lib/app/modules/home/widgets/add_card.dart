import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
        onTap: () {},
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
}
