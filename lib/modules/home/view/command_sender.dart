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
              homeController.sendCommand(cmd: 'left');
              // await scanController.scanDevices();
            },
          ),
          const Spacer(),
          AsynIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            rotatedTuen: 2,
            onTap: () async {
              homeController.sendCommand(cmd: 'right');
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
