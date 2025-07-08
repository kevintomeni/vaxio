import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'core/theme/theme_notifier.dart';
import 'app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import 'bloc/theme/theme_bloc.dart';

void main() {
  // Injection des contrôleurs globaux
  Get.put(AuthController());
  Get.put(ThemeController());
  // Ajoute ici d'autres contrôleurs globaux si besoin
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: const VaxioApp(),
    ),
  );
}
