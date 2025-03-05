import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/auth/presentation/widget/register_widget/image_picker_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockFile extends Mock implements File {}

class MockCallback extends Mock {
  void call();
}

void main() {
  late MockCallback mockOnCameraTap;
  late MockCallback mockOnGalleryTap;

  setUp(() {
    mockOnCameraTap = MockCallback();
    mockOnGalleryTap = MockCallback();
  });

  testWidgets('Displays default image when no image is provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImagePickerWidget(
            image: null,
            onCameraTap: () {},
            onGalleryTap: () {},
          ),
        ),
      ),
    );

    final avatar = find.byType(CircleAvatar);
    expect(avatar, findsNWidgets(2));
    expect(avatar.first, findsOneWidget);
  });

  testWidgets('Opens modal bottom sheet when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImagePickerWidget(
            image: null,
            onCameraTap: mockOnCameraTap.call,
            onGalleryTap: mockOnGalleryTap.call,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsOneWidget);
    expect(find.text('Camera'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);
  });

  testWidgets('Calls onCameraTap when Camera button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImagePickerWidget(
            image: null,
            onCameraTap: mockOnCameraTap.call,
            onGalleryTap: mockOnGalleryTap.call,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Camera'));
    await tester.pump();

    verify(() => mockOnCameraTap()).called(1);
  });

  testWidgets('Calls onGalleryTap when Gallery button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImagePickerWidget(
            image: null,
            onCameraTap: mockOnCameraTap.call,
            onGalleryTap: mockOnGalleryTap.call,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gallery'));
    await tester.pump();

    verify(() => mockOnGalleryTap()).called(1);
  });
}
