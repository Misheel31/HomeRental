import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/onboarding/presentation/widget/build_image_container.dart';

void main() {
  testWidgets('buildImageContainer renders with correct content',
      (WidgetTester tester) async {
    const testTitle = 'Find Your Dream House';
    const testSubtitle =
        'Browse through thousands of listings to find your perfect home.';
    const testImagePath = 'assets/images/image.png';

    tester.binding.window.physicalSizeTestValue = const Size(340, 620);
    tester.binding.window.devicePixelRatioTestValue = 3.0;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data:
              const MediaQueryData(size: Size(340, 620)), 
          child: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return buildImageContainer(
                  context,
                  Colors.blue,
                  testTitle,
                  testSubtitle,
                  testImagePath,
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(find.text(testTitle), findsOneWidget);
    expect(find.text(testSubtitle), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.image, isA<AssetImage>());
    expect((image.image as AssetImage).assetName, testImagePath);

    final containerFinder = find.byType(Container);
    final container = tester.firstWidget<Container>(containerFinder);
    final padding = container.padding as EdgeInsets;

    expect(padding.horizontal, equals(40));
    expect(padding.vertical, equals(60));
  });
}
