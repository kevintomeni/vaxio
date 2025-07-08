import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _mode = ThemeMode.light.obs;
  ThemeMode get mode => _mode.value;
  void toggle() => _mode.value = _mode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}
