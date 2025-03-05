import 'dart:io';

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
  });

  group('AuthRepository Tests', () {
    test('should return failure when registerUser fails', () async {
      const user = AuthEntity(
          email: 'h@gmail.com', username: 'hello', password: '123456');
      when(() => mockAuthRepository.registerUser(user)).thenAnswer(
        (_) async => const Left(ApiFailure(message: "Api Failure")),
      );

      final result = await mockAuthRepository.registerUser(user);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) => fail('Expected Failure'),
      );
    });

    test('should return success when loginUser is successful', () async {
      const email = 'test@example.com';
      const password = 'password';
      when(() => mockAuthRepository.loginUser(email, password)).thenAnswer(
        (_) async => const Right('auth_token'),
      );

      final result = await mockAuthRepository.loginUser(email, password);

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected auth token'),
        (authToken) => expect(authToken, 'auth_token'),
      );
    });

    test('should return failure when uploadProfilePicture fails', () async {
      final file = File('path/to/file');
      when(() => mockAuthRepository.uploadProfilePicture(file)).thenAnswer(
        (_) async => const Left(ApiFailure(message: 'Failure')),
      );

      final result = await mockAuthRepository.uploadProfilePicture(file);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) => fail('Expected Failure'),
      );
    });

    test('should return current user when getCurrentUser is successful',
        () async {
      const authEntity = AuthEntity(email: '', username: '', password: '');
      when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
        (_) async => const Right(authEntity),
      );

      final result = await mockAuthRepository.getCurrentUser();

      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected auth entity'),
        (user) => expect(user, authEntity),
      );
    });
  });
}
