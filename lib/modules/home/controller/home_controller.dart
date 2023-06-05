import 'package:esp_remote/headers/headers.dart';

import '../../../sockets/ws_api.dart';

class HomeController extends GetxController {
  final _socketStream = StreamController<dynamic>.broadcast();
  final deviceMessageController = TextEditingController();
  final loading = true.obs;
  StreamSubscription<dynamic>? _subscription;
  WsSocketApi? api;
  final deviceIp = ''.obs;
  final deviceName = ''.obs;
  final command = 0.obs;

  @override
  void onInit() {
    if (deviceIp.value != '') {
      connectDevice();
    }
    super.onInit();
  }

  void initialValues() {
    command.value = 0;
    loading.value = true;
    deviceMessageController.text = 'Loading State! Please W8';
  }

  Future<bool> connectDevice() async {
    if (deviceIp.value != '') {
      if (api != null) {
        api!.disconnect();
      }

      final sc = Get.find<ScanController>();
      final device = await sc.getDeviceInfo(deviceIp.value);
      if (device == null) {
        updateIp(deviceIp.value);
        return false;
      }

      if (device.isLocked == true) {
        Get.snackbar('Device Locked', 'Device is Already Locked!');
        Get.offAndToNamed(AppPages.scan);
        Get.find<ScanController>().scanDevices();
        return false;
      }
      try {
        deviceName.value = device.name;

        api = WsSocketApi(deviceIp.value);
        _subscription = api!.stream.listen((data) {
          deviceMessageController.text = data;
          _socketStream.add(data);
        });
        deviceMessageController.text = 'Connection Established';
      } catch (e) {
        if (kDebugMode) {
          print('Errror!   $e');
        }
        return false;
      }

      return true;
    }
    return false;
  }

  void disconnectDevice() {
    if (_subscription != null) {
      _subscription!.cancel();
    }
    if (api != null) {
      api!.disconnect();
      api = null;
    }
    initialValues();
  }

  Future<bool> updateIp(String ip) async {
    loading.value = true;
    deviceIp.value = ip;
    disconnectDevice();
    final res = await connectDevice();
    loading.value = false;
    return res;
  }

  void sendCommand({String cmd = 'toggle'}) {
    if (api != null) {
      api!.send(cmd);
    } else {
      Get.snackbar(
          'Error', 'Please Go back to Scan Screen and Try to Connect again');
    }
    // api.send(cmd);
  }

  void addNumber() {}

  @override
  void onClose() {
    disconnectDevice();
    super.onClose();
  }
}
