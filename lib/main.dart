import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:have_to_do/app/data/services/storage/services.dart';
import 'app/modules/home/view.dart';

void main(List<String> args) async {
  // Initializing get storage
  await GetStorage.init();
  // Injecting getX service
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Have Todo',
      home: HomePage(),
    );
  }
}
