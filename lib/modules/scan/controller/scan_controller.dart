import 'dart:io';

import 'package:esp_remote/headers/headers.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;

class ScanController extends GetxController {
  final ipAddressS = '192.168.10.';
  final List<Device> devices = <Device>[].obs;

  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 1));
    scanDevices();
    super.onReady();
  }

  void scanDevices() async {
    devices.clear();

    final nc = Get.find<NetworkController>();
    if (nc.connectionStatus.value == 1 || nc.connectionStatus.value == 2) {
      final ip = nc.ips.value;
      if (ip.isNotEmpty) {
        final baseVal = removeDigitsAfterLastDot(ip);
        final connect = GetConnect();
        for (int i = 0; i < 256; i++) {
          connect.get(baseUrl(baseVal, i)).then((value) {
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
