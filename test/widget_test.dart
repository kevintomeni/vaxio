// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vaxio/app.dart';
import 'package:vaxio/views/login_view.dart';
import 'package:vaxio/controllers/auth_controller.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construire notre application et déclencher un frame.
    await tester.pumpWidget(const VaxioApp());

    // Vérifier que notre compteur commence à 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  group('AuthController', () {
    late AuthController controller;

    setUp(() {
      controller = AuthController();
    });

    test('Initial state is not logged in', () {
      expect(controller.isLoggedIn, false);
      expect(controller.currentUser, null);
    });

    // Pour tester login/register/forgot/reset, mocke ApiService et StorageService
    test('Login with valid credentials', () async {
      final response = await controller.login('test@example.com', 'password');
      expect(response, true);
      expect(controller.isLoggedIn, true);
      expect(controller.currentUser, isNotNull);
    });

    // Utilise mockito ou mocktail pour simuler les réponses API
    test('Forgot password', () async {
      final response = await controller.forgotPassword('test@example.com');
      expect(response, true);
    });

  testWidgets('Affiche le formulaire de connexion', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthController(),
        child: const MaterialApp(home: LoginView()),
      ),
    );
    expect(find.text('Welcome\nBack.'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
});
}