import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/view/login_view.dart';
import 'package:home_rental/features/home/presentation/widget/bottom_navigation_bar.dart';
import 'package:home_rental/features/onboarding/domain/enity/onboarding_entity.dart';
import 'package:home_rental/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingBloc extends Mock implements OnboardingBloc {}

class FakeOnboardingState extends Fake implements OnboardingState {}

class FakeOnboardingEntity extends Fake implements OnboardingEntity {}

void main() {
  late MockOnboardingBloc mockBloc;

  setUp(() {
    mockBloc = MockOnboardingBloc();
    registerFallbackValue(FakeOnboardingState());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<OnboardingBloc>.value(
        value: mockBloc,
        child: Scaffold(
          body: CustomBottomNavigationBar(
            selectedIndex: 1,
            onItemTapped: (index) {},
          ),
        ),
      ),
    );
  }

  testWidgets('CustomBottomNavigationBar renders correctly',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnboardingState(
      currentIndex: 0,
      onboardingItems: List.generate(5, (index) => FakeOnboardingEntity()),
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pump();
  });

  testWidgets('Tapping Skip button calls skipToLastPage()',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnboardingState(
      currentIndex: 0,
      onboardingItems: List.generate(5, (index) => FakeOnboardingEntity()),
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    final skipButton = find.widgetWithText(TextButton, "Skip");
    expect(skipButton, findsOneWidget);
    await tester.tap(skipButton);
  });

  testWidgets('Tapping Next button moves to the next page',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnboardingState(
      currentIndex: 0,
      onboardingItems: List.generate(5, (index) => FakeOnboardingEntity()),
    ));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    debugPrint(tester.allWidgets.toString());

    final nextButton = find.widgetWithText(TextButton, "Next");
    expect(nextButton, findsOneWidget);

    await tester.tap(nextButton);
    await tester.pump();

    verify(() => mockBloc.updateCurrentIndex(1)).called(1);
  });

  testWidgets('Tapping Get Started button navigates to LoginView',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnboardingState(
      currentIndex: 1,
      onboardingItems: List.generate(5, (index) => FakeOnboardingEntity()),
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    final getStartedButton = find.text("Get Started");
    expect(getStartedButton, findsOneWidget);

    await tester.tap(getStartedButton);
    await tester.pumpAndSettle();

    expect(find.byType(LoginView), findsOneWidget);
  });
}
