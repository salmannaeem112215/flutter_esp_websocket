import 'dart:io';

import 'package:esp_remote/headers/headers.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class ScanController extends GetxController {
  final ipAddressS = '192.168.10.';
  final List<Device> devices = <Device>[
    Device(
      name: 'ESP-1',
      isConnected: false,
      isLocked: true,
      ip: '192.168.10.7',
    ),
    Device(
      name: 'ESP-2',
      isConnected: false,
      isLocked: true,
      ip: '192.168.10.6',
    ),
    Device(
      name: 'ESP-3',
      isConnected: false,
      isLocked: true,
      ip: '192.168.10.5',
    ),
    Device(
      name: 'ESP-4',
      isConnected: false,
      isLocked: false,
      ip: '192.168.10.4',
    ),
  ].obs;

  @override
  void onReady() async {
    // await Future.delayed(const Duration(seconds: 1));
    // scanDevices();
    super.onReady();
  }

// import 'dart:async';

  Future<void> scanDevices() async {
    devices.clear();

    final nc = Get.find<NetworkController>();
    if (nc.connectionStatus.value == 1 || nc.connectionStatus.value == 2) {
      final ip = nc.ips.value;
      if (ip.isNotEmpty) {
        final baseVal = removeDigitsAfterLastDot(ip);
        final connect = GetConnect();
        final requests = <Future>[];

        for (int i = 0; i < 256; i++) {
          final request = connect.get(baseUrl(baseVal, i)).then((value) {
            if (value.statusCode == 200) {
              final res = getDeviceNameAndStatus(value.body);
              if (res != null) {
                devices.add(
                  Device(
                    name: res[0] ?? '',
                    isConnected: res[1] == 'Connected',
                    isLocked: res[1] == 'Connected',
                    ip: baseUrl(baseVal, i),
                  ),
                );
              }
            }
          });

          requests.add(request);
        }

        try {
          await Future.wait(requests).timeout(Duration(seconds: 20));
          // Rest of the function after all requests are done within the time limit.
        } catch (e) {
          // Timeout occurred, handle the timeout here.
          print('Timeout occurred. Stopping ongoing requests.');
        }
      } else {
        Get.snackbar('Internet Error', 'Please Try Again');
      }
    } else {
      Get.snackbar('Internet Error', 'Please Connect your Phone with Wifi');
    }
  }

  String removeDigitsAfterLastDot(String ipAddress) {
    int lastDotIndex = ipAddress.lastIndexOf('.');
    return ipAddress.substring(0, lastDotIndex + 1);
  }

  List<String?>? getDeviceNameAndStatus(String input) {
    String deviceNameRegex = r"Device Name: (.+)";
    String statusRegex = r"Status: (.+)";

    RegExp deviceNamePattern = RegExp(deviceNameRegex);
    RegExp statusPattern = RegExp(statusRegex);

    Match? deviceNameMatch = deviceNamePattern.firstMatch(input);
    Match? statusMatch = statusPattern.firstMatch(input);

    if (deviceNameMatch != null && statusMatch != null) {
      String? deviceName = deviceNameMatch.group(1);
      String? status = statusMatch.group(1);
      return [deviceName, status];
    } else {
      return null;
    }
  }
}

String baseUrl(String baseVal, int val) => 'http://$baseVal$val:80/info';
