import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/app/di/di.dart';
import 'package:home_rental/core/theme/app_theme.dart';
import 'package:home_rental/features/splash/presentation/view/splash_view.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rentify',
      theme: getApplication(),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashView(),
      ),
    );
  }
}
