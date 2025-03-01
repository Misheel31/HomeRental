part of 'login_bloc.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? token;

  LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.token,
  });

  LoginState.initial()
      : isLoading = false,
        isSuccess = false,
        token = null;

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? token,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      token: token ?? this.token,
    );
  }

  LoginState.authenticated(String token)
      : isLoading = false,
        isSuccess = true,
        token = token;

  LoginState.failed()
      : isLoading = false,
        isSuccess = false,
        token = null;
}
