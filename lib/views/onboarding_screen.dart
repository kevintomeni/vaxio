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
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo
              Image.asset('assets/images/logo.png', height: 48),
              const SizedBox(height: 24),
              const Text(
                "Bienvenue sur Vaxio",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Gérez votre santé et votre futur en toute simplicité.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: PageView(
                  children: [
                    _OnboardingPage(
                      image: 'assets/images/splash1.png',
                      title: "Suivi vaccinal",
                      description: "Gardez une trace de vos vaccins et rappels.",
                    ),
                    _OnboardingPage(
                      image: 'assets/images/splash2.png',
                      title: "Rendez-vous médicaux",
                      description: "Prenez rendez-vous facilement avec des professionnels.",
                    ),
                    _OnboardingPage(
                      image: 'assets/images/splash3.png',
                      title: "Notifications & rappels",
                      description: "Recevez des rappels pour ne rien oublier.",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(OnboardingCompleted());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Commencer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image, height: 220),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
