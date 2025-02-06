import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/use_case/create_property_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockPropertyRepository repository;
  late CreatePropertyUseCase useCase;

  setUp(() {
    repository = MockPropertyRepository();
    useCase = CreatePropertyUseCase(propertyRepository: repository);
    registerFallbackValue(const PropertyEntity(
      title: '',
      description: '',
      location: '',
      image: '',
      pricePerNight: 0.0,
      available: false,
      bedCount: 0,
      bedroomCount: 0,
      city: '',
      state: '',
      country: '',
      amenities: [],
      bathroomCount: 0,
      guestCount: 0,
    ));
  });

  const params = CreatePropertyParams(
    title: '',
    description: '',
    location: '',
    image: '',
    pricePerNight: '0.0',
    available: false,
    bedCount: 0,
    bedroomCount: 0,
    city: '',
    state: '',
    country: '',
    guestCount: 0,
    bathroomCount: 0,
    amenities: [],
  );

  test('should call the [CreateRepo.createProperty]', () async {
    when(() => repository.createProperty(any()))
        .thenAnswer((_) async => const Right(null));

    final result = await useCase(params);
    expect(result, const Right(null));

    verify(() => repository.createProperty(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
