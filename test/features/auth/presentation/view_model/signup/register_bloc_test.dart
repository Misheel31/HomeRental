import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:home_rental/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUserUsecase extends Mock implements RegisterUserUsecase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

class RegisterUserParamsFake extends Fake implements RegisterUserParams {}

class UploadImageParamsFake extends Fake implements UploadImageParams {}

class MockScaffoldMessenger extends Mock implements ScaffoldMessengerState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockBuildContext';
  }
}

void main() {
  late MockRegisterUserUsecase mockRegisterUserUsecase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late RegisterBloc registerBloc;

  setUpAll(() {
    registerFallbackValue(RegisterUserParamsFake());
    registerFallbackValue(UploadImageParamsFake());
  });

  setUp(() {
    mockRegisterUserUsecase = MockRegisterUserUsecase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    registerBloc = RegisterBloc(
        registerUserUseCase: mockRegisterUserUsecase,
        uploadImageUsecase: mockUploadImageUsecase);

    registerFallbackValue(File('test_path'));
  });

  group('RegistrationBloc Test', () {
    test('should emit success when registration is successful', () async {
      when(() => mockRegisterUserUsecase.call(any()))
          .thenAnswer((_) async => const Right(null));

      final mockContext = MockBuildContext();
      final mockScaffoldMessenger = MockScaffoldMessenger();

      // Mock required methods on context
      when(() => mockContext.findAncestorStateOfType<ScaffoldMessengerState>())
          .thenReturn(mockScaffoldMessenger);

      registerBloc.add(RegisterUser(
          context: mockContext,
          email: 'test@email.com',
          username: 'user',
          password: 'password123',
          confirmPassword: 'password123'));

      await expectLater(
          registerBloc.stream,
          emitsInOrder([
            const RegisterState(isLoading: true, isSuccess: false),
            const RegisterState(isLoading: false, isSuccess: true),
          ]));
    });

    test('should emit failure state when registration fails', () async {
      when(() => mockRegisterUserUsecase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Invalid credentials')));

      registerBloc.add(RegisterUser(
          context: MockBuildContext(),
          email: 'wrong@gmail.com',
          username: 'wronguser',
          password: 'wrongpassword',
          confirmPassword: 'wrongpassword'));

      await expectLater(
        registerBloc.stream,
        emitsInOrder([
          const RegisterState(isLoading: true, isSuccess: false),
          const RegisterState(isLoading: false, isSuccess: false),
        ]),
      );
    });

    test('should emit success state when image is uploaded successfully',
        () async {
      when(() => mockUploadImageUsecase.call(any()))
          .thenAnswer((_) async => const Right('image_name'));

      registerBloc.add(UploadImage(file: File('test_path')));

      await expectLater(
          registerBloc.stream,
          emitsInOrder([
            const RegisterState(
                isLoading: true, isSuccess: false, imageName: null),
            const RegisterState(
                isLoading: false, isSuccess: true, imageName: 'image_name'),
          ]));
    });

    test('should emit failure state when image upload fails', () async {
      when(() => mockUploadImageUsecase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Upload failed')));

      registerBloc.add(UploadImage(file: File('test_path')));

      await expectLater(
          registerBloc.stream,
          emitsInOrder([
            const RegisterState(
                isLoading: true, isSuccess: false, imageName: null),
            const RegisterState(
                isLoading: false, isSuccess: false, imageName: null),
          ]));
    });
  });
}
