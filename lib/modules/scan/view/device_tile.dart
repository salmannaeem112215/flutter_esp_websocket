import 'package:esp_remote/headers/headers.dart';

class DeviceTile extends StatelessWidget {
  const DeviceTile({
    super.key,
    required this.device,
  });
  final Device device;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: Text(device.isLocked ? 'Locked' : 'Avaliable'),
      onTap: () {
        Get.toNamed(
          AppPages.home,
          arguments: device,
        );
      },
    );
  }
}
