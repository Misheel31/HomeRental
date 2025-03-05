import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/presentation/widget/property_description.dart';

void main() {
  testWidgets('property description expands and collapses', (tester) async {
    const fullDescription =
        'This is a long property description that should be truncated when not expanded.';
    bool isExpanded = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return PropertyDescription(
              description: fullDescription,
              isExpanded: isExpanded,
              onToggleDescription: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            );
          },
        ),
      ),
    ));

    final expectedTruncatedText = fullDescription.length > 100
        ? '${fullDescription.substring(0, 100)}...'
        : fullDescription;

    final foundTexts = find.byType(Text);
    print('Found text widgets: $foundTexts');

    expect(find.text(expectedTruncatedText), findsOneWidget);
    expect(find.text('Read More'), findsOneWidget);
    expect(find.text('Read Less'), findsNothing);

    await tester.tap(find.text('Read More'));
    await tester.pump();

    expect(find.text(fullDescription), findsOneWidget);
    expect(find.text('Read Less'), findsOneWidget);
    expect(find.text('Read More'), findsNothing);

    await tester.tap(find.text('Read Less'));
    await tester.pump();

    expect(find.text(expectedTruncatedText), findsOneWidget);
    expect(find.text('Read More'), findsOneWidget);
    expect(find.text('Read Less'), findsNothing);
  });
}
