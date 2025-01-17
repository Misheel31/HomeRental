import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_rental/app/usecase/usecase.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:home_rental/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String email;
  final String username;
  final String password;

  const RegisterUserParams(
      {required this.email, required this.username, required this.password});

  //Inital Constructor
  const RegisterUserParams.initial(
      {required this.email, required this.password, required this.username});

  @override
  List<Object?> get props => [username, email, password];
}

class RegisterUserUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUserUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity =
        AuthEntity(email: params.email, username: params.username, password: params.password);
    return repository.registerUser(authEntity);
  }
}
