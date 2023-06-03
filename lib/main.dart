import 'package:esp_remote/headers/headers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESP Remote',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes(),
      initialBinding: NetworkBinding(),
    );
  }
}
