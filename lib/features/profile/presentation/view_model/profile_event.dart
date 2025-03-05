part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrentUser extends ProfileEvent {
  const GetCurrentUser();

  @override
  List<Object?> get props => [];
}
