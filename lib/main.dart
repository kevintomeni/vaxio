import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vaxio/Vue/Auth/signIn/sign_in_page.dart';
import 'package:vaxio/Vue/Auth/signUp/sign_up_page.dart';
import 'package:vaxio/Vue/Loading_page/loadingPage.dart';
import 'package:vaxio/Vue/Onboarding/onboarding_page.dart';
import 'package:vaxio/Vue/Home/home_page.dart';
import 'package:vaxio/utils/index.dart';
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
        initialLocation: '/',
        routes: [
          GoRoute(
            path: AppConstants.routeSignUp,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: AppConstants.routeSignIn,
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            path: AppConstants.routeLoading,
            builder: (context, state) => const LoadingPage(),
          ),
          GoRoute(
            path: AppConstants.routeOnboarding,
            builder: (context, state) => const OnboardingPage(),
          ),
          GoRoute(
            path: AppConstants.routeHome,
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
    );
  }
}
