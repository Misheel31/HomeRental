import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/splash/presentation/view/splash_view.dart';
import 'package:home_rental/features/splash/presentation/view_model/splash_cubit.dart';

class MockSplashCubit extends MockCubit<void> implements SplashCubit {}

void main() {
  late MockSplashCubit mockSplashCubit;

  setUp(() {
    mockSplashCubit = MockSplashCubit();
  });

  testWidgets('SplashView displays content correctly', (tester) async {
    await tester.pumpWidget(
      BlocProvider<SplashCubit>(
        create: (_) => mockSplashCubit,
        child: const MaterialApp(
          home: SplashView(),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);

    expect(find.text('Rentify'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    expect(find.text('version : 1.0.0'), findsOneWidget);
  });

  testWidgets('SplashView adjusts layout based on screen size (tablet)',
      (tester) async {
    const double tabletWidth = 800;

    await tester.pumpWidget(
      BlocProvider<SplashCubit>(
        create: (_) => mockSplashCubit,
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return const SplashView();
                },
              );
            },
          ),
        ),
      ),
    );

    tester.binding.window.physicalSizeTestValue = const Size(tabletWidth, 600);
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);

    final imageWidget = tester.widget<Image>(find.byType(Image));
    expect(imageWidget.width, 350);

    final titleText = tester.widget<Text>(find.text('Rentify'));
    expect(titleText.style?.fontSize, 36);
  });

  testWidgets('SplashView adjusts layout based on screen size (mobile)',
      (tester) async {
    const double mobileWidth = 400;

    await tester.pumpWidget(
      BlocProvider<SplashCubit>(
        create: (_) => mockSplashCubit,
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return const SplashView();
                },
              );
            },
          ),
        ),
      ),
    );

    tester.binding.window.physicalSizeTestValue = const Size(mobileWidth, 600);
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);

    final imageWidget = tester.widget<Image>(find.byType(Image));
    expect(imageWidget.width, 250);

    final titleText = tester.widget<Text>(find.text('Rentify'));
    expect(titleText.style?.fontSize, 28);
  });
}
