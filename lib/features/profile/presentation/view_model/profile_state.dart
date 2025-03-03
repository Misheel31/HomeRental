part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

// Error State
class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

// Image Upload Success State
class ProfileImageUploaded extends ProfileState {
  final String imageUrl;

  ProfileImageUploaded(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}
