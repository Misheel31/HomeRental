import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/onboarding/domain/enity/onboarding_entity.dart';
import 'package:home_rental/features/onboarding/domain/use_case/get_onboarding_data.dart';
import 'package:home_rental/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetOnboardingData extends Mock implements GetOnboardingData {}

void main() {
  late MockGetOnboardingData mockGetOnboardingData;
  late OnboardingBloc onboardingBloc;

  setUp(() {
    mockGetOnboardingData = MockGetOnboardingData();
    when(() => mockGetOnboardingData()).thenReturn([
      OnboardingEntity(
          title: 'Title 1', description: 'Description 1', image: 'image1'),
      OnboardingEntity(
          title: 'Title 2', description: 'Description 2', image: 'image2'),
      OnboardingEntity(
          title: 'Title 3', description: 'Description 3', image: 'image3'),
    ]);
    onboardingBloc = OnboardingBloc(mockGetOnboardingData);
  });

  group('OnboardingBloc', () {
    test('initial state is correct', () {
      expect(onboardingBloc.state.onboardingItems.length, 3);
      expect(onboardingBloc.state.currentIndex, 0);
    });

    test('nextPage updates currentIndex correctly', () {
      onboardingBloc.nextPage();
      expect(onboardingBloc.state.currentIndex, 1);
      onboardingBloc.nextPage();
      expect(onboardingBloc.state.currentIndex, 2);

      onboardingBloc.nextPage();
      expect(onboardingBloc.state.currentIndex, 2);
    });

    test('skipToLastPage sets the currentIndex to the last page', () {
      onboardingBloc.skipToLastPage();
      expect(onboardingBloc.state.currentIndex, 2);
    });

    test('updateCurrentIndex updates currentIndex correctly', () {
      onboardingBloc.updateCurrentIndex(1);
      expect(onboardingBloc.state.currentIndex, 1);

      onboardingBloc.updateCurrentIndex(0);
      expect(onboardingBloc.state.currentIndex, 0);
    });
  });
}
