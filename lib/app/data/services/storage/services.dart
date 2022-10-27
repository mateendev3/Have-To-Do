import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  // init the service
  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.writeIfNull(keyTasks, []);
    return this;
  }

  // write data
  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  // read data
  T? read<T>(String key) {
    return _box.read(key);
  }
}
