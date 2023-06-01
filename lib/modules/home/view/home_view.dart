import 'package:esp_remote/headers/headers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final networkController = Get.find<NetworkController>();
    final homeController = Get.find<HomeController>();
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Obx(
              () => Text(
                networkController.connectionStatus.value == 1
                    ? 'Wifi: Connected!'
                    : networkController.connectionStatus.value == 2
                        ? 'Mobile Internet Connected!'
                        : 'No Connection',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                const Text('Output - GPIO 2'),
                Text('State: '),
                ElevatedButton(
                  onPressed: () => homeController.sendCommand(),
                  child: const Text('Toogle'),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
