import 'package:esp_remote/headers/headers.dart';

class ScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanController>(
      () => ScanController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
