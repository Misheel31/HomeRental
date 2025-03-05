import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/app/di/di.dart';
import 'package:home_rental/core/theme/app_theme.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:home_rental/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:home_rental/features/profile/data/data_source/remote_datasource/profile_remote_datasource.dart';
import 'package:home_rental/features/profile/data/repository/profile_remote_repository/profile_remote_repository.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';
import 'package:home_rental/features/property/presentation/view_model/property_cubit.dart';
import 'package:home_rental/features/splash/presentation/view/splash_view.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:home_rental/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:home_rental/features/wishlist/presentation/view_model/wishlist_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<SplashCubit>()),
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<RegisterBloc>()),
        BlocProvider(create: (_) => getIt<OnboardingBloc>()),
        BlocProvider(
          create: (_) => getIt<ProfileBloc>(),
        ),
        BlocProvider(
          create: (_) => PropertyCubit(
              getAllPropertyUsecase: getIt<GetAllPropertyUsecase>()),
        ),
        BlocProvider(create: (_) => getIt<WishlistBloc>()),
        BlocProvider(
          create: (_) => WishlistBloc(getIt<IWishlistRepository>()),
        ),
        Provider(
          create: (_) => FetchUserUsecase(
            ProfileRemoteRepository(
              getIt<ProfileRemoteDatasource>(),
              getIt<Dio>(),
              getIt<SharedPreferences>(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rentify',
        theme: AppTheme.getApplication(),
        home: const SplashView(),
      ),
    );
  }
}
