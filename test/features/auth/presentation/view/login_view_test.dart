import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/view/login_view.dart';

void main() {
  final loginViewState = LoginViewState();

  group('Email Validation Tests', () {
    test('validateEmail should return error if email is empty', () {
      final result = loginViewState.validateEmail('');
      expect(result, 'Email is required');
    });

    test('validateEmail should return error if email is invalid', () {
      final result = loginViewState.validateEmail('invalid-email');
      expect(result, 'Enter a valid email address');
    });

    test('validateEmail should return null if email is valid', () {
      final result = loginViewState.validateEmail('test@example.com');
      expect(result, null);
    });
  });

  group('Password Validation Tests', () {
    test('validatePassword should return error if password is empty', () {
      final result = loginViewState.validatePassword('');
      expect(result, 'Password is required');
    });

    test('validatePassword should return null if password is valid', () {
      final result = loginViewState.validatePassword('password123');
      expect(result, null);
    });
  });
}
