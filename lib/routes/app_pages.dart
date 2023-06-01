import 'package:esp_remote/headers/headers.dart';

class AppPages {
  static const String home = '/';
  static const String view = '/view';
  static const String initial = home;

  static List<GetPage> routes() => [
        GetPage(
          name: home,
          page: () => const HomeScreen(),
          // binding: HomeBinding(),
        ),
      ];
}
