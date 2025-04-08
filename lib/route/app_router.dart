import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Vue/Loading_page/loadingPage.dart';
import '../Vue/Home_page/homePage.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'loading',
        builder: (context, state) => const Loadingpage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      // Ajoutez d'autres routes ici
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Page non trouvée: ${state.error}')),
        ),
  );
}
