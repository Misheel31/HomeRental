import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:home_rental/features/auth/domain/use_case/upload_image_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUsecase _registerUserUsecase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc(
      {required RegisterUserUsecase registerUserUseCase,
      required UploadImageUsecase uploadImageUsecase})
      : _registerUserUsecase = registerUserUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUserUsecase.call(RegisterUserParams(
      email: event.email,
      username: event.username,
      password: event.password,
      image: state.imageName,
    ));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
      // showMySnackBar(
      //     context: event.context,
      //     message: "Registration Successful",
      //     color: Colors.green);
    });
  }

  void _onLoadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
