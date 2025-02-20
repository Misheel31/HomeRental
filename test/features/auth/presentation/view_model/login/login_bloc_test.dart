import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:home_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();

    registerFallbackValue(const AuthEntity(
      email: 'test@email.com',
      password: 'password',
      username: 'username',
    ));
  });

  group('Login Use Case Test', () {
    test('should return a token when login is successful', () async {
      when(() => mockAuthRepository.loginUser(any(), any())).thenAnswer(
        (_) async => const Right('token'),
      );

      final result =
          await mockAuthRepository.loginUser('test@email.com', 'password');

      expect(result, equals(const Right('token')));
    });

    test('should return a failure when login fails', () async {
      when(() => mockAuthRepository.loginUser(any(), any())).thenAnswer(
        (_) async => const Left(ApiFailure(message: 'Invalid credentials')),
      );

      final result = await mockAuthRepository.loginUser(
          'wrong@email.com', 'wrongpassword');

      expect(result,
          equals(const Left(ApiFailure(message: 'Invalid credentials'))));
    });

    test('should return a valid result for registerUser', () async {
      when(() => mockAuthRepository.registerUser(any())).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await mockAuthRepository.registerUser(const AuthEntity(
        email: 'test@gmail.com',
        password: 'password',
        username: 'username',
      ));

      expect(result, equals(const Right(null)));
    });
  });
}
