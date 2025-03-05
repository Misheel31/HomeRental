part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final AuthEntity? user;
  final String? errorMessage;

  const ProfileState({
    required this.isLoading,
    this.user,
    this.errorMessage,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      user: null,
      errorMessage: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    AuthEntity? user,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, errorMessage];
}
