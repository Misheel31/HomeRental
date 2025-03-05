import 'package:flutter/material.dart';
import 'package:home_rental/app/app.dart';
import 'package:home_rental/app/di/di.dart';
import 'package:home_rental/core/network/hive_service.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await initDependencies();
  final splashCubit = getIt<SplashCubit>();
  print(splashCubit);
  runApp(const MyApp());
}
