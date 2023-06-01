// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:flutter/foundation.dart';

class SocketApi {
  static late String url = '192.168.10.4:80';

  // static String get kWsUrl => 'ws://$url/$_WS';
  static String get kWsUrl => 'ws://192.168.10.4/ws';

  static const _WS = "ws/";
}
