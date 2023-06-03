import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsSocketApi {
  WsSocketApi(String ip)
      : _api = WebSocketChannel.connect(
          Uri.parse(
            baseUrl(ip),
          ),
        );
  final WebSocketChannel _api;
  Stream<dynamic> get stream => _api.stream.map<dynamic>((data) {
        print('websocket Data: $data');
        return data;
      });

  ValueChanged<String> get send => _api.sink.add;

  static String baseUrl(String ip) => 'ws://$ip/ws';

  void disconnect() {
    _api.sink.add(cmdDisconnect);
    _api.sink.close();
  }

  void connect(ip) {
    // _api = ;
  }

  static const String cmdDisconnect = 'disconnect';
  static const String cmdToggle = 'toggle';
}
