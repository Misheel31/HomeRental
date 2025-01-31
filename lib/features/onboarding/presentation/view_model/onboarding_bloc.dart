import 'package:bloc/bloc.dart';
import 'package:home_rental/features/onboarding/domain/enity/onboarding_entity.dart';
import 'package:home_rental/features/onboarding/domain/use_case/get_onboarding_data.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Cubit<OnboardingState> {
  final GetOnboardingData getOnboardingData;

  OnboardingBloc(this.getOnboardingData)
      : super(OnboardingState(
          onboardingItems: getOnboardingData(),
          currentIndex: 0,
        ));

  void nextPage() {
    if (state.currentIndex < state.onboardingItems.length - 1) {
      emit(OnboardingState(
        onboardingItems: state.onboardingItems,
        currentIndex: state.currentIndex + 1,
      ));
    }
  }

  void skipToLastPage() {
    emit(OnboardingState(
      onboardingItems: state.onboardingItems,
      currentIndex: state.onboardingItems.length - 1,
    ));
  }

  void updateCurrentIndex(int index) {
    emit(OnboardingState(
      onboardingItems: state.onboardingItems,
      currentIndex: index,
    ));
  }
}