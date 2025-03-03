import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchUserUsecase fetchUserUsecase;

  ProfileBloc(this.fetchUserUsecase) : super(ProfileInitial()) {
    on<FetchUserEvent>(_onFetchUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<GetUserProfileEvent>(_onGetUserProfile);
  }

  Future<void> _onFetchUser(
      FetchUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await fetchUserUsecase.fetchUser();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onUpdateUser(
      UpdateUserEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await fetchUserUsecase.updateUser(event.user);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(ProfileLoaded(event.user)),
    );
  }

  Future<void> _onGetUserProfile(
      GetUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await fetchUserUsecase.getUserProfile();

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }
}
