import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_rental/core/network/api_service.dart';
import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:home_rental/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:home_rental/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:home_rental/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:home_rental/features/auth/domain/use_case/login_usecase.dart';
import 'package:home_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:home_rental/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:home_rental/features/home/presentation/view_model/home_cubit.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();

  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // =========================== Data Source ===========================
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  // init remote data source
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );

  // init remote repository
  getIt.registerLazySingleton(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Usecases ===========================

  // register use usecase
  // getIt.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );
  getIt.registerLazySingleton<RegisterUserUsecase>(
    () => RegisterUserUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUserUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Usecases ===========================

  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
