import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/onboarding/onboarding_bloc.dart';
import 'bloc/role/role_bloc.dart';

void main() {
 
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => OnboardingBloc()),
        BlocProvider(create: (_) => RoleBloc()),
      ],
      child: const VaxioApp(),
    ),
  );
}
