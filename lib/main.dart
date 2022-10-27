import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/data/services/storage/services.dart';
import 'app/modules/home/binding.dart';
import 'app/modules/home/view.dart';

void main(List<String> args) async {
  // Initializing get storage
  await GetStorage.init();
  // Injecting getX service
  await Get.putAsync(() => StorageService().init());
  // Initializing Screen Utils (package)
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Have Todo',
      home: Builder(
        builder: (context) {
          ScreenUtil.init(context);
          return const HomePage();
        },
      ),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
