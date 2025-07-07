import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaxio/views/login_view.dart';
import 'package:vaxio/cubit/auth_cubit.dart';

void main() {
  testWidgets('Affiche une erreur si email invalide', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
          child: const LoginView(),
        ),
      ),
    );
    await tester.enterText(find.byType(TextFormField).first, 'notanemail');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Sign up'));
    await tester.pump();
    expect(find.text("Format d'email invalide"), findsOneWidget);
  });

  testWidgets('Affiche une erreur si mot de passe trop court', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
          child: const LoginView(),
        ),
      ),
    );
    await tester.enterText(find.byType(TextFormField).first, 'test@mail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.text('Sign up'));
    await tester.pump();
    expect(find.text("Mot de passe trop court"), findsOneWidget);
  });
} 