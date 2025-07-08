import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_routes.dart';
import 'views/splash_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/login_view.dart';
import 'views/register_page.dart';
import 'views/change_password_page.dart';
import 'views/reset_password_page.dart';
import 'views/home_view.dart';
import 'views/role_selection_page.dart';
import 'core/constants/app_constants.dart';
import 'views/profile_info_page.dart';
import 'bloc/theme/theme_bloc.dart';
import 'views/otp_page.dart';

class VaxioApp extends StatelessWidget {
  const VaxioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: state.themeMode,
            initialRoute: AppRoutes.splash,
            routes: {
              AppRoutes.splash: (context) => const SplashScreen(),
              AppRoutes.onboarding: (context) => const OnboardingScreen(),
              AppRoutes.roleSelection: (context) => const RoleSelectionPage(),
              AppRoutes.login: (context) => const LoginView(),
              AppRoutes.register: (context) => const RegisterPage(),
              AppRoutes.forgot: (context) => const ResetPasswordPage(),
              AppRoutes.verify: (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return OTPVerificationPage(email: args?['email'] ?? '');
              },
              AppRoutes.home: (context) => const HomeView(),
              AppRoutes.profileInfo: (context) => const ProfileInfoPage(),
            },
          );
        },
      ),
    );
  }
}