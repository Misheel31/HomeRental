import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/app/di/di.dart';
import 'package:home_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:home_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:home_rental/features/home/presentation/view_model/home_cubit.dart';
import 'package:home_rental/features/onboarding/domain/use_case/get_onboarding_data.dart';
import 'package:home_rental/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:home_rental/features/onboarding/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/onboarding/presentation/widget/build_image_container.dart';

import '../../../auth/domain/use_case/login_usecase.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

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
      child: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return PageView(
            controller: controller,
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
          );
        },
      ),
      bottomSheet: CustomBottomNavigationBar(controller: controller),
    );
  }
}
