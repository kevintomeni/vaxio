import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/animated_logo.dart';
import '../widgets/animated_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  Widget build(BuildContext context) {
    // Le reste du code est déjà présent en dehors de la sélection.
    return Container(); // Ceci est un placeholder, le vrai contenu est déjà dans le fichier.
  }

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoAnimation = Tween<double>(begin: -120, end: 0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _textAnimation = Tween<double>(begin: 120, end: 0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutBack),
    );

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 600), () => _textController.forward());

    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(animation: _logoAnimation),
                const SizedBox(height: 24),
                AnimatedText(animation: _textAnimation, text: 'Vaxio'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }
}