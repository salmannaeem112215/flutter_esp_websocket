import 'package:esp_remote/headers/headers.dart';

class NetworkController extends GetxController {
  final connectionStatus = 0.obs;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      _updateConnectionStatus(event);
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        Get.snackbar("Network Error", "Failed to Get Network");
        break;
    }
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }
}
