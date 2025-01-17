import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/core/common/snackbar/my_snackbar.dart';
import 'package:home_rental/features/auth/domain/use_case/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUserUsecase _registerUserUsecase;

  RegisterBloc({required RegisterUserUsecase registerUserUseCase})
      : _registerUserUsecase = registerUserUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
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
    ));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
      showMySnackBar(
          context: event.context, message: "Registration Successful", color: Colors.green);
    });
  }
}
