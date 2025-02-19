import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../property/domain/use_case/token.mock.dart';
import 'auth_repo.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase useCase;

  setUp(() {
    repository = AuthRepoMock();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUseCase(repository, tokenSharedPrefs);
    
  });

  test(
    'should call the [AuthRepo.login] with correct email and password(abc@gmail.com, 123456789)',
    () async {
      when(() => repository.loginUser(any(), any()))
          .thenAnswer((invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'abc@gmail.com' && password == '123456789') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(
              const Left(ApiFailure(message: 'Invalid email or password')));
        }
      });

      when(() => tokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right(null));

      when(() => tokenSharedPrefs.getToken())
          .thenAnswer((_) async => const Right('token'));

      final result = await useCase(
          const LoginParams(email: 'abc@gmail.com', password: '123456789'));

      expect(result, const Right('token'));

      verify(() => repository.loginUser(any(), any())).called(1);

      verify(() => tokenSharedPrefs.saveToken(any())).called(1);

      verify(() => tokenSharedPrefs.getToken()).called(1);

      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(tokenSharedPrefs);
    },
  );
  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
