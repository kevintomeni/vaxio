// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vaxio/core/theme/theme_notifier.dart';
import 'package:vaxio/views/login_view.dart';
import 'package:vaxio/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:vaxio/services/api_service.dart';
import 'package:vaxio/views/register_page.dart';

// Crée une classe mock
class MockApiService extends Mock implements ApiService {}

void setupMockSharedPreferences() {
  SharedPreferences.setMockInitialValues({});
}

void main() {
  late AuthController authController;
  late MockApiService mockApiService;

  setUp(() {
    setupMockSharedPreferences();
    mockApiService = MockApiService();
    ApiService.setInstance(mockApiService);
    authController = AuthController();

    // Mock toutes les méthodes utilisées
    // ignore: cast_from_null_always_fails
    when(mockApiService.login(any as String, any as String)).thenAnswer((_) async => {
      'user': {'id': '1', 'name': 'Test', 'email': 'test@test.com'},
      'token': 'fake_token',
    });
    // La méthode forgotPassword n'est pas définie dans MockApiService, donc on retire ce mock pour corriger l'erreur.
  });

  group('AuthController', () {
    setUp(() {
      // Remplace l'instance singleton par le mock via un setter ou une méthode publique
      ApiService.setInstance(mockApiService);
    });

    test('L\'état initial n\'est pas connecté', () {
      expect(authController.isLoggedIn, false);
      expect(authController.currentUser, null);
    });

    test('login success', () async {
      print('Test login success lancé');
      // Arrange
      when(mockApiService.login('test@test.com', 'password')).thenAnswer(
        (_) async => {
          'user': {
            'id': '1',
            'name': 'Test',
            'email': 'test@test.com',
          },
          'token': 'fake_token',
        },
      );

      // Act
      final result = await authController.login('test@test.com', 'password');

      // Assert
      expect(result, true);
      expect(authController.currentUser?.email, 'test@test.com');
      expect(authController.error, isNull);
    });

    test('login error', () async {
      // Arrange
      when(mockApiService.login('wrong@test.com', 'wrong')).thenThrow(Exception('Email ou mot de passe incorrect'));

      // Act
      final result = await authController.login('wrong@test.com', 'wrong');

      // Assert
      expect(result, false);
      expect(authController.error, contains('Email ou mot de passe incorrect'));
    });

    // Utilise mockito ou mocktail pour simuler les réponses API
    test('Forgot password', () async {
      final response = await authController.forgotPassword('test@example.com');
      expect(response, true);
    });

    testWidgets('Affiche le formulaire de connexion', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => authController),
            ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ],
          child: const MaterialApp(home: LoginView()),
        ),
      );
      expect(find.text('Welcome\nBack.'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Affiche le formulaire d\'inscription et soumet', (WidgetTester tester) async {
      final authController = AuthController();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => authController),
            ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ],
          child: const MaterialApp(home: RegisterPage()),
        ),
      );

      // Vérifie la présence des champs
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Remplit les champs
      await tester.enterText(find.byType(TextFormField).at(0), 'newuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'new@test.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'password');

      // Appuie sur le bouton
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Ici, tu pourrais mocker le succès et vérifier la navigation ou l'affichage d'un message
    });

    test('register success', () async {
      // Arrange
      when(mockApiService.register('newuser', 'new@test.com', 'password')).thenAnswer(
        (_) async => {
          'user': {
            'id': '2',
            'name': 'newuser',
            'email': 'new@test.com',
          },
          'token': 'new_fake_token',
        },
      );

      // Act
      final result = await authController.register('newuser', 'new@test.com', 'password');

      // Assert
      expect(result, true);
      expect(authController.currentUser?.email, 'new@test.com');
      expect(authController.error, isNull);
    });
  });
}