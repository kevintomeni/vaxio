import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

class _SignUpPageState {
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'L\'email est requis';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Entrez un email valide';
    }
    return null;
  }

  String? _validatePhone(String phone) {
    if (phone.isEmpty) {
      return 'Le numéro de téléphone est requis';
    } else if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      return 'Entrez un numéro de téléphone valide';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Le mot de passe est requis';
    } else if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('SignUpPage Validations', () {
    test('Email validation should return error for empty email', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validateEmail('');
      expect(result, 'L\'email est requis');
    });

    test('Email validation should return error for invalid email', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validateEmail('invalid-email');
      expect(result, 'Entrez un email valide');
    });

    test('Email validation should return null for valid email', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validateEmail('test@example.com');
      expect(result, null);
    });

    test('Phone validation should return error for empty phone', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validatePhone('');
      expect(result, 'Le numéro de téléphone est requis');
    });

    test('Phone validation should return error for invalid phone', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validatePhone('12345');
      expect(result, 'Entrez un numéro de téléphone valide');
    });

    test('Phone validation should return null for valid phone', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validatePhone('0123456789');
      expect(result, null);
    });

    test('Password validation should return error for empty password', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validatePassword('');
      expect(result, 'Le mot de passe est requis');
    });

    test('Password validation should return error for short password', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validatePassword('12345');
      expect(result, 'Le mot de passe doit contenir au moins 6 caractères');
    });

    test('Password validation should return null for valid password', () {
      final signUpPageState = _SignUpPageState();
      final result = signUpPageState._validatePassword('123456');
      expect(result, null);
    });
  });

}