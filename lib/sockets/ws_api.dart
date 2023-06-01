import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'api.dart';

class WsSocketApi {
  WsSocketApi() : _api = WebSocketChannel.connect(Uri.parse(SocketApi.kWsUrl));

  final WebSocketChannel _api;

  Stream<dynamic> get stream => _api.stream.map<dynamic>((data) {
        print('websocket Data: $data');
        return data;
      });

  ValueChanged<String> get send => _api.sink.add;
}
