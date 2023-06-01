import 'package:esp_remote/headers/headers.dart';
import 'package:esp_remote/modules/scan/view/device_tile.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    final scanController = Get.find<ScanController>();
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => scanController.scanDevices(),
          child: const Icon(
            Icons.find_replace_rounded,
          )),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Scan Devices',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(() {
                  final sValue = networkController.connectionStatus.value;
                  final status = sValue == 1
                      ? 'Wifi: Connected!'
                      : sValue == 2
                          ? 'Mobile Internet Connected!'
                          : 'No Connection';
                  print(status);
                  return Tooltip(
                    message: status,
                    child: Icon(
                      sValue == 1
                          ? Icons.wifi_rounded
                          : sValue == 2
                              ? Icons.wifi_rounded
                              : Icons.wifi_off_rounded,
                      color: Colors.grey,
                    ),
                  );
                })
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Obx(() {
              return Flexible(
                child: ListView.builder(
                  itemBuilder: (_, index) => DeviceTile(
                      key: Key(scanController.devices[index].ip),
                      device: scanController.devices[index]),
                  itemCount: scanController.devices.length,
                ),
              );
            }),
          ],
        ),
      )),
    );
  }
}
