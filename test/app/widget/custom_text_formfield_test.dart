import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/app/widget/custom_text_formfield.dart';

void main() {
  group('CustomTextFormField widget test', () {
    testWidgets('renders widget with label text', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CustomTextFormfield(
              onPressed: () {}, text: "Email", controller: controller),
        ),
      ));

      expect(find.text('Email'), findsOneWidget);
    });
  });
}
