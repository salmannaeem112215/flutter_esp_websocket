import 'package:esp_remote/headers/headers.dart';

import '../../scan/view/asyn_icon_btn.dart';

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ESP-4',
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
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Message From Device'),
                    SizedBox(height: 10),
                    TextField(
                      enabled: false,
                      maxLines: 3,
                      controller: homeController.deviceMessageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Obx(() {
              //   return Flexible(
              //     child: ListView.separated(
              //       separatorBuilder: (_, index) => const Divider(height: 1),
              //       itemBuilder: (_, index) => DeviceTile(
              //           key: Key(scanController.devices[index].ip),
              //           device: scanController.devices[index]),
              //       itemCount: scanController.devices.length,
              //     ),
              //   );
              // }),
              const Spacer(),
              const Divider(height: 1),
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(Icons.exposure_minus_1),
                        ),
                      ),
                      SizedBox(width: 70, child: TextField()),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(Icons.exposure_minus_1),
                        ),
                      ),
                      const Spacer(),
                      AsynIconButton(
                        img: 'assets/icons/scan.png',
                        onTap: () async {
                          homeController.sendCommand();
                          // await scanController.scanDevices();
                        },
                      ),
                    ],
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
