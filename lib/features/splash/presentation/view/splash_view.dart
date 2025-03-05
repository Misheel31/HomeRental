import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBE7F9),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isTablet = constraints.maxWidth > 600;

        return Center(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: isTablet ? 350 : 250,
                  child: Image.asset('assets/images/Apartment rent-amico.png'),
                ),
                Text(
                  'Rentify',
                  style: TextStyle(
                    fontSize: isTablet ? 36 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: isTablet ? 60 : 50,
                  height: isTablet ? 60 : 50,
                ),
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                Text(
                  'version : 1.0.0',
                  style: TextStyle(fontSize: isTablet ? 18 : 14),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
