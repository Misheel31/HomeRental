import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/view/register_view.dart';

void main() {
  final registerViewState = RegisterViewState();

  group('Email Validation Tests', () {
    test('validateEmail should return error if email is empty', () {
      final result = registerViewState.validateEmail('');
      expect(result, 'Please enter your email');
    });

    test('validateEmail should return error if email is invalid', () {
      final result = registerViewState.validateEmail('invalid-email');
      expect(result, 'Please enter a valid email');
    });

    test('validateEmail should return null if email is valid', () {
      final result = registerViewState.validateEmail('test@example.com');
      expect(result, null);
    });
  });

  group('Username Validation Tests', () {
    test('validateUsername should return error if username is empty', () {
      final result = registerViewState.validateUsername('');
      expect(result, 'Please enter your username');
    });

    test('validateUsername should return null if username is valid', () {
      final result = registerViewState.validateUsername('testusername');
      expect(result, null);
    });
  });

  group('Password Validation Tests', () {
    test('validatePassword should return error if password is empty', () {
      final result = registerViewState.validatePassword('');
      expect(result, 'Please enter your password');
    });

    test('validatePassword should return error if password is too short', () {
      final result = registerViewState.validatePassword('123');
      expect(result, 'Password must be at least 6 characters long');
    });

    test('validatePassword should return null if password is valid', () {
      final result = registerViewState.validatePassword('password123');
      expect(result, null);
    });
  });

  group('Confirm Password Validation Tests', () {
    test(
        'validateConfirmPassword should return error if confirm password is empty',
        () {
      final result = registerViewState.validateConfirmPassword('');
      expect(result, 'Please confirm your password');
    });

    test(
        'validateConfirmPassword should return error if passwords do not match',
        () {
      registerViewState.passwordController.text = 'password123';
      final result = registerViewState.validateConfirmPassword('password124');
      expect(result, 'Passwords do not match');
    });

    test('validateConfirmPassword should return null if passwords match', () {
      registerViewState.passwordController.text = 'password123';
      final result = registerViewState.validateConfirmPassword('password123');
      expect(result, null);
    });
  });
}
