import 'package:esp_remote/headers/headers.dart';

import '../../scan/view/asyn_icon_btn.dart';

class CommandSender extends StatelessWidget {
  const CommandSender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          AsynIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () async {
              homeController.sendCommand(cmd: '0');
              // await scanController.scanDevices();
            },
          ),
          const Spacer(),
          AsynIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            rotatedTuen: 2,
            onTap: () async {
              print('gu');
              homeController.sendCommand(cmd: '1');
              // await scanController.scanDevices();
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
