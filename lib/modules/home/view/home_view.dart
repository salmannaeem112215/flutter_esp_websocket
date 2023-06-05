import 'package:esp_remote/headers/headers.dart';
import 'package:esp_remote/modules/home/view/left_right.dart';

import 'command_sender.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    final homeController = Get.find<HomeController>();
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
          child: Obx(
            () => homeController.loading.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                homeController.disconnectDevice();
                                Get.back();
                              },
                              child:
                                  const Icon(Icons.arrow_back_ios_new_rounded)),
                          Text(
                            homeController.deviceName.value,
                            style: kAppHeaderTitle,
                          ),
                          Obx(() {
                            final sValue =
                                networkController.connectionStatus.value;
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
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Device Details',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            Text(
                                '     Name: ${homeController.deviceName.value}'),
                            const SizedBox(height: 3),
                            Text(
                              '     IP Address: ${homeController.deviceIp.value}',
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const Text(
                              'Message From Device',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              enabled: false,
                              maxLines: 3,
                              controller:
                                  homeController.deviceMessageController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const LeftRightButtons(),
                      const Spacer(),
                      const Divider(height: 1),
                      const CommandSender(),
                    ],
                  ),
          ),
        )),
      ),
    );
  }
}
