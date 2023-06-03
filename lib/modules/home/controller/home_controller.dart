import 'package:esp_remote/headers/headers.dart';

import '../../../sockets/ws_api.dart';

class HomeController extends GetxController {
  final _socketStream = StreamController<dynamic>.broadcast();
  final deviceMessageController = TextEditingController();
  StreamSubscription<dynamic>? _subscription;
  WsSocketApi? api;
  final deviceIp = ''.obs;
  final command = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (deviceIp.value != '') {
      connectDevice();
    }
  }

  void connectDevice() {
    print(deviceIp.value);
    if (deviceIp.value != '') {
      if (api != null) {
        api!.disconnect();
      }

      api = WsSocketApi(deviceIp.value);
      _subscription = api!.stream.listen((data) {
        deviceMessageController.text = data;
        _socketStream.add(data);
      });
    }
  }

  void disconnectDevice() {
    if (_subscription != null) {
      _subscription!.cancel();
    }
    if (api != null) {
      api!.disconnect();
      api = null;
    }
  }

  void updateIp(String ip) {
    deviceIp.value = ip;
    disconnectDevice();
    connectDevice();
  }

  void sendCommand({String cmd = 'toggle'}) {
    // api.send(cmd);
    api!.send(command.toString());
  }

  void addNumber() {}

  @override
  void onClose() {
    disconnectDevice();
    super.onClose();
  }
}
