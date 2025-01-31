import 'package:home_rental/features/onboarding/domain/enity/onboarding_entity.dart';

class GetOnboardingData {
  List<OnboardingEntity> call() {
    return [
      OnboardingEntity(
          title: "Find Your Dream Home",
          description:
              "Browse through thousands of listings to find your perfect home.",
          image: "assets/images/onboarding1.webp"),
      OnboardingEntity(
          title: "Filter and Compare",
          description:
              "Use advanced filters and compare options to make an informed decision.",
          image: "assets/images/onboarding2.png"),
      OnboardingEntity(
          title: "Secure Your Stay",
          description: "Book and rent your home with ease and confidence.",
          image: "assets/images/onboarding3.png"),
    ];
  }
}
