import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/presentation/view/property_view.dart';
import 'package:home_rental/features/property/presentation/view_model/property_bloc.dart';
import 'package:home_rental/features/property/presentation/view_model/property_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockPropertyCubit extends Mock implements PropertyCubit {}

void main() {
  late MockPropertyCubit mockPropertyCubit;

  setUp(() {
    mockPropertyCubit = MockPropertyCubit();
  });

  Widget createTestWidget() {
    return BlocProvider<PropertyCubit>.value(
      value: mockPropertyCubit,
      child: const MaterialApp(
        home: PropertyView(),
      ),
    );
  }

  testWidgets('Displays a loading indicator while fetching properties',
      (WidgetTester tester) async {
    when(() => mockPropertyCubit.state).thenReturn(
        const PropertyState(isLoading: true, properties: [], error: null));

    await tester.pumpWidget(createTestWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays a list of properties when data is available',
      (WidgetTester tester) async {
    final properties = [
      const PropertyEntity(
          title: 'Test Property 1',
          location: 'Location 1',
          description: 'beautiful place',
          image: 'image.png',
          pricePerNight: 200,
          bedCount: 2,
          bedroomCount: 2,
          available: true,
          city: 'Abc',
          state: 'Abc',
          amenities: ['wifi', 'ppol'],
          country: 'ABc',
          bathroomCount: 2,
          guestCount: 2),
      const PropertyEntity(
          title: 'Test Property 2',
          location: 'Location 2',
          description: 'beautiful place',
          image: 'image.png',
          pricePerNight: 200,
          bedCount: 2,
          bedroomCount: 2,
          available: true,
          city: 'Abc',
          state: 'Abc',
          amenities: ['wifi', 'ppol'],
          country: 'ABc',
          bathroomCount: 2,
          guestCount: 2),
    ];

    when(() => mockPropertyCubit.state).thenReturn(
        PropertyState(isLoading: false, properties: properties, error: null));

    await tester.pumpWidget(createTestWidget());
    await tester.pump();

    expect(find.text('Test Property 1'), findsOneWidget);
    expect(find.text('Test Property 2'), findsOneWidget);
    expect(find.text('Location 1'), findsOneWidget);
    expect(find.text('Location 2'), findsOneWidget);
  });

  testWidgets('Displays an error message when fetching fails',
      (WidgetTester tester) async {
    when(() => mockPropertyCubit.state).thenReturn(const PropertyState(
        isLoading: false, properties: [], error: "Failed to load"));

    await tester.pumpWidget(createTestWidget());

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Failed to load'), findsNothing);
  });
}
