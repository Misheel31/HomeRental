import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_rental/features/auth/presentation/view/login_view.dart';
import 'package:home_rental/features/onboarding/presentation/view_model/onboarding_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final PageController controller;

  const CustomBottomNavigationBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      final currentIndex = controller.page?.round() ?? 0;
      context.read<OnboardingBloc>().updateCurrentIndex(currentIndex);
    });

    return Container(
      color: const Color.fromARGB(255, 215, 221, 252),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.read<OnboardingBloc>().skipToLastPage();
              controller.jumpToPage(controller.initialPage + 7);
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 18, color: Color(0xFF5D4037)),
            ),
          ),
          BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(state.onboardingItems.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.jumpToPage(index);
                          context
                              .read<OnboardingBloc>()
                              .updateCurrentIndex(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.currentIndex == index
                                ? const Color(0xFF5D4037)
                                : const Color.fromARGB(255, 141, 126, 121),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
          BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return state.currentIndex == state.onboardingItems.length - 1
                  ? TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5D4037),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Get Started",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFFCF5D7)),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        "Next",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF5D4037)),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
