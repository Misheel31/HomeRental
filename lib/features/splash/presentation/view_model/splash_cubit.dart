import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:home_rental/features/onboarding/presentation/view/onboarding_view.dart.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._onboardingBloc) : super(null);

  final LoginBloc _onboardingBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onboardingBloc,
              child: const OnboardingView(),
            ),
          ),
        );
      }
    });
  }
}
