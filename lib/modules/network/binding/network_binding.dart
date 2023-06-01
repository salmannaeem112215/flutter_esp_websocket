import 'package:esp_remote/headers/headers.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(
      () => NetworkController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
