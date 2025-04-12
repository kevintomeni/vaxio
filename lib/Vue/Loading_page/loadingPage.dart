import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/utils/index.dart';
import 'loading_cubit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _logoAnimation;
  late final Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Initialisation de l'AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Animation pour le logo
    _logoAnimation = _createSlideAnimation(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    );

    // Animation pour le texte
    _textAnimation = _createSlideAnimation(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    );

    // Démarrage de l'animation
    _controller.forward();
  }

  // Méthode pour créer une animation de type SlideTransition
  Animation<Offset> _createSlideAnimation({
    required Offset begin,
    required Offset end,
  }) {
    return Tween<Offset>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoadingCubit()..startLoading(),
      child: BlocListener<LoadingCubit, bool>(
        listener: (context, isLoading) {
          if (!isLoading) {
            // Navigation vers la page suivante lorsque le chargement est terminé
            context.go(AppConstants.routeOnboarding);
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedLogo(),
                _buildAnimatedText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Méthode pour construire le logo animé
  Widget _buildAnimatedLogo() {
    return SlideTransition(
      position: _logoAnimation,
      child: Image.asset('assets/images/logo.png', width: 150),
    );
  }

  // Méthode pour construire le texte animé
  Widget _buildAnimatedText() {
    return SlideTransition(
      position: _textAnimation,
      child: Text('Vaxio', style: AppTextStyles.h1),
    );
  }
}
