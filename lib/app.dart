import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'cubit/theme_cubit.dart';
import 'core/routes/app_routes.dart';
import 'views/splash_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/login_view.dart';
import 'views/register_page.dart';
import 'views/forgot_password_page.dart';
import 'views/verify_email_page.dart';
import 'views/home_view.dart';
import 'views/role_selection_page.dart';
import 'core/constants/app_constants.dart';
import 'views/profile_info_page.dart';

class VaxioApp extends StatelessWidget {
  const VaxioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
          themeMode: mode,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.onboarding: (_) => const OnboardingScreen(),
        AppRoutes.login: (_) => const LoginView(),
        AppRoutes.register: (_) => const RegisterPage(),
        AppRoutes.forgot: (_) => const ForgotPasswordPage(),
        AppRoutes.verify: (context) {
              final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
              return VerifyEmailPage(contact: args['contact'], otp: args['otp']);
        },
        AppRoutes.home: (_) => const HomeView(),
        AppRoutes.roleSelection: (_) => const RoleSelectionPage(),
        AppRoutes.otp: (context) {
              final args = ModalRoute.of(context)!.settings.arguments as String;
              return OTPPage(contact: args);
            },
        AppRoutes.profileInfo: (_) => const ProfileInfoPage(),
      },
    );
  },
);
  }
}
