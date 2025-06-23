import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'core/routes/app_routes.dart';
import 'views/splash_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/login_view.dart';
import 'views/register_page.dart';
import 'views/forgot_password_page.dart';
import 'views/verify_email_page.dart';
import 'views/home_view.dart';
import 'controllers/auth_controller.dart';
import 'core/constants/app_constants.dart';

class VaxioApp extends StatelessWidget {
  const VaxioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: Provider.of<ThemeNotifier>(context).mode,
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (_) => const SplashScreen(),
          AppRoutes.onboarding: (_) => const OnboardingScreen(),
          AppRoutes.login: (_) => const LoginView(),
          AppRoutes.register: (_) => const RegisterPage(),
          AppRoutes.forgot: (_) => const ForgotPasswordPage(),
          AppRoutes.verify: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as String;
            return VerifyEmailPage(email: args);
          },
          AppRoutes.home: (_) => const HomeView(),
        },
      ),
    );
  }
}
