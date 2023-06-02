import 'dart:async';

import 'package:esp_remote/headers/headers.dart';
import 'package:get/get.dart';

import '../../../sockets/ws_api.dart';

class HomeController extends GetxController {
  final _socketStream = StreamController<dynamic>.broadcast();
  final deviceMessageController = TextEditingController();
  StreamSubscription<dynamic>? _subscription;
  final api = WsSocketApi();
  final deviceIp = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (deviceIp.value != '') {
      _loadDevice();
    }
  }

  void _loadDevice() {
    print('Loadeed Bus Caalled');
    _subscription = api.stream.listen((data) {
      deviceMessageController.text = data;
      _socketStream.add(data);
    });
    // api.send('toggle');
  }

  void updateIp(String ip) {
    deviceIp.value = ip;
    if (_subscription != null) {
      _subscription!.cancel();
    }
    _loadDevice();
  }

  void sendCommand({String cmd = 'toggle'}) {
    api.send(cmd);
  }
}
