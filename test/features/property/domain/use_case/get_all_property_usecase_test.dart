import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockPropertyRepository repository;
  late GetAllPropertyUsecase usecase;

  setUp(() {
    repository = MockPropertyRepository();
    usecase = GetAllPropertyUsecase(propertyRepository: repository);
  });

  const tProperty = PropertyEntity(
    title: 'hell',
    description: 'abcd',
    location: 'London',
    image: 'image',
    pricePerNight: 120,
    available: true,
    bedCount: 1,
    bedroomCount: 1,
    city: 'abc',
    state: 'abc',
    country: 'Uk',
    amenities: [],
    bathroomCount: 1,
    guestCount: 1,
  );

  const tProperty2 = PropertyEntity(
    title: 'hell1',
    description: 'abcd',
    location: 'USA',
    image: 'image',
    pricePerNight: 20,
    available: true,
    bedCount: 1,
    bedroomCount: 1,
    city: 'abc',
    state: 'abc',
    country: 'Uk',
    amenities: [],
    bathroomCount: 1,
    guestCount: 1,
  );

  final tProperties = [tProperty, tProperty2];

  testWidgets('get all property usecase ...', (tester) async {
    when(() => repository.getAllProperties())
        .thenAnswer((_) async => Right(tProperties));

    final result = await usecase();
    expect(result, Right(tProperties));
    verify(() => repository.getAllProperties()).called(1);
  });
}
