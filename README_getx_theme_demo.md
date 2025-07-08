# Mini projet Flutter GetX : Thème dynamique

## 1. pubspec.yaml (ajoute get: ^4.6.5)
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5

## 2. lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme_controller.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();
      return GetMaterialApp(
        title: 'GetX Theme Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.mode,
        home: const HomePage(),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(title: const Text('GetX Theme Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: themeController.toggle,
          child: const Text('Changer le thème'),
        ),
      ),
    );
  }
}
```

## 3. lib/theme_controller.dart
```dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _mode = ThemeMode.light.obs;
  ThemeMode get mode => _mode.value;
  void toggle() => _mode.value = _mode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}
```

---

- Lance ce projet avec `flutter run`.
- Tu dois voir un bouton "Changer le thème" qui bascule entre clair et sombre sans aucune erreur.
- Si ce mini-projet fonctionne, ton problème est bien lié au cache ou à la structure de ton projet principal. 