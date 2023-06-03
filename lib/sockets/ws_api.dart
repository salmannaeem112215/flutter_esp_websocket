import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../headers/headers.dart';

class WsSocketApi {
  WsSocketApi(String ip)
      : _api = WebSocketChannel.connect(
          Uri.parse(
            baseUrl(ip),
          ),
        );

  final WebSocketChannel _api;

  Stream<dynamic> get stream => _api.stream.map<dynamic>((data) {
        return data;
      });

  ValueChanged<String> get send => _api.sink.add;

  static String baseUrl(String ip) => 'ws://$ip/ws';

  void disconnect() {
    _api.sink.add(cmdDisconnect);
    _api.sink.close();
  }

  Future<bool> connect() async {
    try {
      await _api.stream.first;
      return true; // Connection successful
    } catch (error) {
      if (kDebugMode) {
        print('Connection failed: $error');
      }
      return false; // Connection failed
    }
  }

  static const String cmdDisconnect = 'disconnect';
  static const String cmdToggle = 'toggle';
}
