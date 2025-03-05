import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/profile/domain/entity/user_entity.dart';
import 'package:home_rental/features/profile/domain/use_case/fetch_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view/profile_view.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchUserUsecase extends Mock implements FetchUserUsecase {}

void main() {
  late MockFetchUserUsecase mockFetchUserUsecase;

  setUpAll(() {
    mockFetchUserUsecase = MockFetchUserUsecase();
  });

  testWidgets('Displays user profile when data is fetched',
      (WidgetTester tester) async {
    when(() => mockFetchUserUsecase.getUserProfile()).thenAnswer((_) async =>
        const dartz.Right(
            UserEntity(username: 'TestUser', email: 'test@gmail.com')));

    await tester.pumpWidget(
        MaterialApp(home: ProfilePage(fetchUserUsecase: mockFetchUserUsecase)));

    await tester.pump();

    expect(find.text('TestUser'), findsOneWidget);
  });

  testWidgets('Displays error message when fetch fails',
      (WidgetTester tester) async {
    when(() => mockFetchUserUsecase.getUserProfile()).thenAnswer((_) async =>
        const dartz.Left(ApiFailure(message: 'Failed to fetch data')));

    await tester.pumpWidget(
        MaterialApp(home: ProfilePage(fetchUserUsecase: mockFetchUserUsecase)));

    await tester.pump();

    expect(find.text('Error: Failed to fetch data'), findsOneWidget);
  });

  testWidgets('Bottom navigation navigates correctly',
      (WidgetTester tester) async {
    when(() => mockFetchUserUsecase.getUserProfile()).thenAnswer((_) async =>
        const dartz.Right(
            UserEntity(username: 'TestUser', email: 'test@gmail.com')));

    await tester.pumpWidget(
        MaterialApp(home: ProfilePage(fetchUserUsecase: mockFetchUserUsecase)));

    await tester.pump();

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();

    expect(find.text('My Wishlist'), findsOneWidget);
  });
}
