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
      tileColor: Colors.white70,
      title: Text(device.name),
      trailing: device.isLocked
          ? const Icon(Icons.lock)
          : const Icon(Icons.lock_open),
      onTap: () {
        if (device.isLocked) {
          Get.snackbar(
            'Device Locked!',
            '${device.name} is locked by some other user. Please Scan Again or Try to connect with other ESP',
            duration: const Duration(seconds: 4),
          );
        } else {
          Get.toNamed(
            AppPages.home,
            arguments: device,
          );
        }
      },
    );
  }
}
