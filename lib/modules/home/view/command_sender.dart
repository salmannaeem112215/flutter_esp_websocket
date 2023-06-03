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
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            InkWell(
              onTap: homeController.command.value <= 0
                  ? null
                  : () {
                      homeController.command.value =
                          homeController.command.value - 1;
                    },
              borderRadius: BorderRadius.circular(2),
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                child: Image.asset(
                  'assets/icons/minus.png',
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(
              width: 50,
              height: 40,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Obx(
                    () => Text(
                      homeController.command.value.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: homeController.command.value >= 15
                  ? null
                  : () {
                      homeController.command.value =
                          homeController.command.value + 1;
                    },
              borderRadius: BorderRadius.circular(2),
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Image.asset(
                  'assets/icons/add.png',
                  color: Colors.black54,
                ),
              ),
            ),
            const Spacer(),
            AsynIconButton(
              img: 'assets/icons/send.png',
              onTap: () async {
                homeController.sendCommand();
                // await scanController.scanDevices();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
