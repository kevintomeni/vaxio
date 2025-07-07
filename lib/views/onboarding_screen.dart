import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<bool> {
  OnboardingCubit() : super(false);
  void complete() => emit(true);
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, bool>(
        listener: (context, completed) {
          if (completed) {
            Navigator.pushReplacementNamed(context, '/login');
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
                  const SizedBox(height: 60),
                  // Logo et nom
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Remplace par ton logo si besoin
                      Icon(Icons.local_hospital, color: Colors.white, size: 32),
                      const SizedBox(width: 8),
                      const Text(
                        'Self Care',
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
                        'assets/images/splash.png',
                        height: 300,
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
                            onPressed: () {
                              context.read<OnboardingCubit>().complete();
                            },
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
      ),
    );
  }
}
