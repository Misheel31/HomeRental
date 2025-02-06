import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_rental/app/shared_prefs/token_shared_prefs.dart';
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
import 'package:home_rental/features/property/data/data_source/remote_datasource/property_remote_datasource.dart';
import 'package:home_rental/features/property/data/repository/property_remote_repository.dart';
import 'package:home_rental/features/property/domain/use_case/create_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/delete_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initSharedPreferences();
  await _initHiveService();
  await _initApiService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initPropertyDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
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
  getIt.registerLazySingleton<AuthLocalDatasource>(
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

_initPropertyDependencies() async {
  // Register the PropertyRemoteDatasource
  getIt.registerLazySingleton<PropertyRemoteDatasource>(
    () => PropertyRemoteDatasource(dio: getIt<Dio>()),
  );

  // Register the PropertyRemoteRepository
  getIt.registerLazySingleton<PropertyRemoteRepository>(
    () => PropertyRemoteRepository(
      getIt<AuthRemoteDataSource>(),
      remoteDataSource: getIt<PropertyRemoteDatasource>(),
    ),
  );

  // Register the GetAllPropertyUsecase
  getIt.registerLazySingleton<GetAllPropertyUsecase>(
    () => GetAllPropertyUsecase(
      propertyRepository: getIt<PropertyRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<CreatePropertyUseCase>(() =>
      CreatePropertyUseCase(
          propertyRepository: getIt<PropertyRemoteRepository>()));

  getIt.registerLazySingleton<DeletePropertyUsecase>(() =>
      DeletePropertyUsecase(
          propertyRepository: getIt<PropertyRemoteRepository>(),
          tokenSharedPrefs: getIt<TokenSharedPrefs>()));
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

  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
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
