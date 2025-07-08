import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaxio/bloc/onboarding/onboarding_bloc.dart';
import '../core/routes/app_routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding/onboarding_state.dart';
import '../bloc/onboarding/onboarding_event.dart';

class OnboardingController extends GetxController {
  var completed = false.obs;
  void complete() {
    completed.value = true;
    Get.offNamed(AppRoutes.roleSelection);
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingDone) {
          Navigator.pushReplacementNamed(context, '/role-selection');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Fond bleu et formes abstraites
            Positioned.fill(
              child: Container(
                color: const Color(0xFF1877F2), // Bleu vif
                child: Stack(
                  children: [
                    // Ajoute ici des Positioned pour les formes vertes et les gélules si tu veux
                  ],
                ),
              ),
            ),
            // Contenu principal
            Column(
              children: [
                const SizedBox(height: 20),
                // Logo et nom
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety, color: Colors.white, size: 32),
                    const SizedBox(width: 8),
                    const Text(
                      'Vaxio',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Image du médecin
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash.jpg',
                      height: 900,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Slogan
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Manage your health and happy future',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.read<OnboardingBloc>().add(OnboardingCompleted()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1877F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Get started',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
