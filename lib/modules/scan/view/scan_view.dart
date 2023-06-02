import 'dart:ui';

import 'package:esp_remote/headers/headers.dart';
import 'package:esp_remote/modules/scan/view/asyn_icon_btn.dart';
import 'package:esp_remote/modules/scan/view/device_tile.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    final scanController = Get.find<ScanController>();
    return Container(
      decoration: const BoxDecoration(
        gradient: kBgGradeint,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Scan Devices',
                    style: kAppHeaderTitle,
                  ),
                  Obx(() {
                    final sValue = networkController.connectionStatus.value;
                    final status = sValue == 1
                        ? 'Wifi: Connected!'
                        : sValue == 2
                            ? 'Mobile Internet Connected!'
                            : 'No Connection';
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
              Obx(() {
                return Flexible(
                  child: ListView.separated(
                    separatorBuilder: (_, index) => const Divider(height: 1),
                    itemBuilder: (_, index) => DeviceTile(
                        key: Key(scanController.devices[index].ip),
                        device: scanController.devices[index]),
                    itemCount: scanController.devices.length,
                  ),
                );
              }),
              const Divider(height: 1),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Center(
                  child: AsynIconButton(
                    img: 'assets/icons/scan.png',
                    onTap: () async {
                      await scanController.scanDevices();
                    },
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
