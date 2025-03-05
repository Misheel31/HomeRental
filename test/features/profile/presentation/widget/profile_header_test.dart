import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/profile/presentation/widget/profile_header.dart'; // Adjust the import based on your file structure

void main() {
  testWidgets('ProfileHeader displays username when provided',
      (WidgetTester tester) async {
    const String username = 'JohnDoe';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileHeader(username: username),
        ),
      ),
    );

    expect(find.text(username),
        findsOneWidget); 
    expect(find.text('Guest'), findsNothing); 
  });

  testWidgets('ProfileHeader displays "Guest" when no username is provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileHeader(),
        ),
      ),
    );

    expect(find.text('Guest'),
        findsOneWidget); 
    expect(find.text('JohnDoe'),
        findsNothing); 
  });
}
