import 'dart:async';

import 'package:get/get.dart';

import '../../../sockets/ws_api.dart';

class HomeController extends GetxController {
  final _socketStream = StreamController<dynamic>.broadcast();
  final api = WsSocketApi();

  @override
  void onInit() {
    super.onInit();
    _loadBuses();
  }

  void _loadBuses() {
    print('Loadeed Bus Caalled');
    api.stream.listen((data) {
      print(data);
      _socketStream.add(data);
    });
    api.send('toggle');
  }

  void sendCommand({String cmd = 'toggle'}) {
    api.send(cmd);
  }
}
