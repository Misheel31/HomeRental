import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/app/di/di.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:home_rental/features/home/presentation/view/home_view.dart';
import 'package:home_rental/features/home/presentation/view_model/home_cubit.dart';
import 'package:home_rental/features/onboarding/domain/use_case/get_onboarding_data.dart';
import 'package:home_rental/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:home_rental/features/onboarding/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/onboarding/presentation/widget/build_image_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/domain/use_case/login_usecase.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(GetOnboardingData()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            loginUseCase: getIt<LoginUseCase>(),
            registerBloc: getIt<RegisterBloc>(),
            homeCubit: getIt<HomeCubit>(),
          ),
        ),
      ],
      child: OnboardingScreen(controller: controller),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  final PageController controller;

  const OnboardingScreen({super.key, required this.controller});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: PageView(
                  controller: widget.controller,
                  onPageChanged: (index) {},
                  children: state.onboardingItems.map((item) {
                    return buildImageContainer(
                      context,
                      const Color.fromARGB(255, 215, 221, 252),
                      item.title,
                      item.description,
                      item.image,
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: CustomBottomNavigationBar(controller: widget.controller),
    );
  }
}
