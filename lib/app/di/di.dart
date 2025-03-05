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
import 'package:home_rental/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:home_rental/features/profile/data/repository/profile_remote_repository/profile_remote_repository.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/domain/use_case/get_current_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:home_rental/features/property/data/data_source/remote_datasource/property_remote_datasource.dart';
import 'package:home_rental/features/property/data/repository/property_remote_repository.dart';
import 'package:home_rental/features/property/domain/use_case/create_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/delete_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:home_rental/features/wishlist/data/data_source/remote_data_source/wishlist_remote_datasource.dart';
import 'package:home_rental/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:home_rental/features/wishlist/data/repository/wishlist_remote_repository.dart/wishlist_remote_repository.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:home_rental/features/wishlist/domain/use_case/get_wishlist_usecase.dart';
import 'package:home_rental/features/wishlist/presentation/view_model/wishlist_bloc.dart';
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
  await _initProfileDependencies();
  _initWishlistDependencies();
}

// Future<void> _initSharedPreferences() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
// }

Future<void> _initSharedPreferences() async {
  // First check if SharedPreferences is already registered
  if (!getIt.isRegistered<SharedPreferences>()) {
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  }
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
  // getIt.registerLazySingleton<RegisterUserUsecase>(
  //   () => RegisterUserUsecase(
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
  getIt.registerLazySingleton<PropertyRemoteDatasource>(
    () => PropertyRemoteDatasource(dio: getIt<Dio>()),
  );

  //   getIt.registerLazySingleton<PropertyRemoteDatasource>(
  //   () => PropertyRemoteDatasource(dio: getIt<Dio>()),
  // );

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

//=======================Profile===================================

_initProfileDependencies() {
  // print("Registering ProfileRemoteDatasource");

  // Register ProfileRemoteDatasource
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasource(getIt<Dio>(), getIt<SharedPreferences>()),
  );

  // Register ProfileRemoteRepository
  getIt.registerLazySingleton<ProfileRemoteRepository>(
    () => ProfileRemoteRepository(getIt<ProfileRemoteDatasource>(),
        getIt<Dio>(), getIt<SharedPreferences>()),
  );

  // Register FetchUserUsecase
  getIt.registerFactory<FetchUserUsecase>(
    () => FetchUserUsecase(getIt<ProfileRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
    ),
  );
}

//=======================Wishlist======================
void _initWishlistDependencies() {
  // Register the data source with the interface (IWishlistDataSource)
  getIt.registerLazySingleton<IWishlistDataSource>(
      () => WishlistRemoteDatasource(dio: getIt<Dio>()));

  getIt.registerLazySingleton<IWishlistRepository>(() =>
      WishlistRemoteRepository(
          remoteDatasource: getIt<WishlistRemoteDatasource>()));

  getIt.registerLazySingleton<GetWishlistUseCase>(
      () => GetWishlistUseCase(getIt<IWishlistRepository>()));

  getIt.registerFactory<WishlistBloc>(
      () => WishlistBloc(getIt<IWishlistRepository>()));
}

//============================Home==============================
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
  getIt.registerLazySingleton<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
