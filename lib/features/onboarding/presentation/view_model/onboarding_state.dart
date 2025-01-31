part of 'onboarding_bloc.dart';

class OnboardingState {
  final List<OnboardingEntity> onboardingItems;
  final int currentIndex;

  OnboardingState({
    required this.onboardingItems,
    required this.currentIndex,
  });
}