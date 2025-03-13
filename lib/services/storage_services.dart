import 'package:get_storage/get_storage.dart';

class StorageServices {
  final box = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  Future<void> write(String key, dynamic value) async {
    await box.write(key, value);
  }

  dynamic read(String key) async {
    return await box.read(key);
  }

}
