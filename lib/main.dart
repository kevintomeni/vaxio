import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/Vue/Loading_page/loadingPage.dart';
import 'package:vaxio/Vue/Onboarding/onboarding_page.dart';
import 'package:vaxio/Vue/Home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: '/loading',
        routes: [
          GoRoute(
            path: '/loading',
            builder: (context, state) => const Loadingpage(),
          ),
          GoRoute(
            path: '/onboarding',
            builder: (context, state) => const OnboardingPage(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
    );
  }
}
