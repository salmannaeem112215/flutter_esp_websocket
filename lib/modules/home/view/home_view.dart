import 'package:esp_remote/headers/headers.dart';

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
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Message From Device'),
                    const SizedBox(height: 10),
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
              const Spacer(),
              const Divider(height: 1),
              CommandSender(),
            ],
          ),
        )),
      ),
    );
  }
}
