import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  // init the service
  Future<StorageService> init() async {
    _box = GetStorage();
    log('**init calling');
    await _box.writeIfNull(keyTasks, []);
    return this;
  }

  // write data
  void write(String key, dynamic value) async {
    log('**write calling');
    await _box.write(key, value);
  }

  // read data
  T? read<T>(String key) {
    var data = _box.read(key);
    log(data.toString());
    log('** calling');
    return data;
  }
}
