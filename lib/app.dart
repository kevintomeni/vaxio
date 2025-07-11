import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_routes.dart';
import 'views/splash_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/login_view.dart';
import 'views/register_page.dart';
import 'views/reset_password_page.dart';
import 'views/home_view.dart';
import 'views/role_selection_page.dart';
import 'core/constants/app_constants.dart';
import 'views/profile_info_page.dart';
import 'bloc/theme/theme_bloc.dart';
import 'views/otp_page.dart';
import 'bloc/role/role_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'views/change_password_page.dart';
import 'views/doctors_page.dart';
import 'views/doctor_detail_page.dart';
import 'views/visit_page.dart';
import 'views/payment_options_page.dart';
import 'views/chat_list_page.dart';
import 'views/recipes_page.dart';
import 'views/video_call_page.dart';

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
              AppRoutes.roleSelection: (context) => BlocProvider(
                create: (_) => RoleBloc(),
                child: RoleSelectionPage(user: null),
              ),
              AppRoutes.login: (context) => const LoginView(),
              AppRoutes.register: (context) => const RegisterPage(),
              AppRoutes.forgot: (context) => const ResetPasswordPage(),
              AppRoutes.verify: (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return OTPVerificationPage(email: args?['email'] ?? '');
              },
              AppRoutes.home: (context) => const HomeView(),
              AppRoutes.profileInfo: (context) => BlocProvider(
                create: (_) => ProfileBloc(),
                child: const ProfileInfoPage(),
              ),
              '/change-password': (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return ChangePasswordPage(
                  email: args?['email'] ?? '',
                  otp: args?['otp'] ?? '',
                );
              },
              '/role-selection': (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return RoleSelectionPage(user: args?['user']);
              },
              '/profile-info': (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return ProfileInfoPage(user: args?['user'], role: args?['role']);
              },
              '/doctors': (context) => const DoctorsPage(),
              '/doctor-detail': (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return DoctorDetailPage(doctorId: args?['id']);
              },
              '/visit': (context) {
                final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
                return VisitPage(doctorId: args?['doctorId']);
              },
              '/payment-options': (context) => const PaymentOptionsPage(),
              '/chat': (context) => const ChatListPage(),
              '/recipes': (context) => const RecipesPage(userId: '1'),
              '/video-call': (context) => const VideoCallPage(
                doctorName: 'Wade Warren',
                doctorSpecialty: 'Psychiatrist',
                doctorAvatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
              ),
            },
          );
        },
      ),
    );
  }
}