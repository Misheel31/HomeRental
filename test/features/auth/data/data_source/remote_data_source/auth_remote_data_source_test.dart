import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AuthRemoteDataSource authRemoteDataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    authRemoteDataSource = AuthRemoteDataSource(mockDio);
  });

  group('AuthRemoteDataSource Tests', () {
    test('registerUser should call POST request and return void on success',
        () async {
      const user = AuthEntity(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        role: 'user',
      );

      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 201,
                requestOptions: RequestOptions(path: ''),
              ));

      await authRemoteDataSource.registerUser(user);

      verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
    });

    test('registerUser should throw Exception when response status is not 201',
        () async {
      const user = AuthEntity(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        role: 'user',
      );

      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 400,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(
        () => authRemoteDataSource.registerUser(user),
        throwsA(isA<Exception>()),
      );
    });

    test('loginUser should return token on successful login', () async {
      const email = 'test@example.com';
      const password = 'password123';

      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 200,
                data: {'token': 'mockToken'},
                requestOptions: RequestOptions(path: ''),
              ));

      final result = await authRemoteDataSource.loginUser(email, password);

      expect(result, 'mockToken');
      verify(() => mockDio.post(any(), data: any(named: 'data'))).called(1);
    });

    test('loginUser should throw Exception on failed login', () async {
      const email = 'test@example.com';
      const password = 'wrongPassword';

      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 400,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(
        () => authRemoteDataSource.loginUser(email, password),
        throwsA(isA<Exception>()),
      );
    });

    test('uploadProfilePicture should throw Exception on failure', () async {
      final file = File('path/to/file');

      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => Response(
                statusCode: 400,
                requestOptions: RequestOptions(path: ''),
              ));

      expect(
        () => authRemoteDataSource.uploadProfilePicture(file),
        throwsA(isA<Exception>()),
      );
    });
  });
}
