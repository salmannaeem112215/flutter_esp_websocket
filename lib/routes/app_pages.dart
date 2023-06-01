import 'package:esp_remote/headers/headers.dart';

class AppPages {
  static const String home = '/';
  static const String scan = '/scan';
  static const String initial = scan;

  static List<GetPage> routes() => [
        GetPage(
          name: home,
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: scan,
          page: () => const ScanScreen(),
          binding: ScanBinding(),
        ),
      ];
}
