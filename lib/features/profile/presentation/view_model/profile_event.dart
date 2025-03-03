part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  final String username;
  const ProfileEvent(this.username);
  @override
  List<Object?> get props => [];
}

class FetchUserEvent extends ProfileEvent {
  const FetchUserEvent(super.username);
}

class UpdateUserEvent extends ProfileEvent {
  final UserEntity user;

  const UpdateUserEvent(this.user) : super('');

  @override
  List<Object?> get props => [user];
}

class GetUserProfileEvent extends ProfileEvent {
  const GetUserProfileEvent(super.username);
}

class UploadProfilePictureEvent extends ProfileEvent {
  final File image;

  const UploadProfilePictureEvent(this.image) : super('');

  @override
  List<Object?> get props => [image];
}
