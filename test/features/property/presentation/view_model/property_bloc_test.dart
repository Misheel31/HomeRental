import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/use_case/create_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/delete_property_usecase.dart';
import 'package:home_rental/features/property/domain/use_case/get_all_property_usecase.dart';
import 'package:home_rental/features/property/presentation/view_model/property_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePropertyUseCase extends Mock implements CreatePropertyUseCase {}

class MockGetAllPropertyUseCase extends Mock implements GetAllPropertyUsecase {}

class MockDeletePropertyUseCase extends Mock implements DeletePropertyUsecase {}

void main() {
  late CreatePropertyUseCase createPropertyUseCase;
  late GetAllPropertyUsecase getAllPropertyUsecase;
  late DeletePropertyUsecase deletePropertyUsecase;
  late PropertyBloc propertyBloc;

  setUp(() {
    createPropertyUseCase = MockCreatePropertyUseCase();
    getAllPropertyUsecase = MockGetAllPropertyUseCase();
    deletePropertyUsecase = MockDeletePropertyUseCase();

    propertyBloc = PropertyBloc(
        createPropertyUseCase: createPropertyUseCase,
        getAllPropertiesUseCase: getAllPropertyUsecase,
        deletePropertyUseCase: deletePropertyUsecase);
  });

  group('PropertyBloc', () {
    const property = PropertyEntity(
        title: 'abc',
        description: 'abc',
        location: 'abc',
        image: 'image',
        pricePerNight: 120,
        available: false,
        bedCount: 1,
        bedroomCount: 2,
        city: 'abc',
        state: 'abc',
        country: 'abc',
        amenities: [],
        bathroomCount: 1,
        guestCount: 1);

    const property2 = PropertyEntity(
        title: 'bcd',
        description: 'bdc',
        location: 'bdc',
        image: 'image',
        pricePerNight: 120,
        available: false,
        bedCount: 1,
        bedroomCount: 2,
        city: 'bcd',
        state: 'bcd',
        country: 'bcd',
        amenities: [],
        bathroomCount: 1,
        guestCount: 1);

    final lstProperty = [property, property2];

    blocTest<PropertyBloc, PropertyState>(
        'emits [PropertyState] with loaded property when LoadProperty is added',
        build: () {
          when(() => getAllPropertyUsecase.call())
              .thenAnswer((_) async => Right(lstProperty));
          return propertyBloc;
        },
        act: (bloc) => bloc.add(LoadProperties()),
        expect: () => [
              PropertyState.initial().copyWith(isLoading: true),
              PropertyState.initial()
                  .copyWith(isLoading: false, properties: lstProperty),
            ],
        verify: (_) {
          verify(() => getAllPropertyUsecase.call()).called(1);
        });

    blocTest<PropertyBloc, PropertyState>(
        'emits [PropertyState] with loaded property when LoadProperty is added with skip 1',
        build: () {
          when(() => getAllPropertyUsecase.call())
              .thenAnswer((_) async => Right(lstProperty));
          return propertyBloc;
        },
        act: (bloc) => bloc.add(LoadProperties()),
        skip: 1,
        expect: () => [
              PropertyState.initial()
                  .copyWith(isLoading: false, properties: lstProperty),
            ],
        verify: (_) {
          verify(() => getAllPropertyUsecase.call()).called(1);
        });

    blocTest<PropertyBloc, PropertyState>(
        'emits [PropertyState] with error when LoadProperty fails',
        build: () {
          when(() => getAllPropertyUsecase.call()).thenAnswer(
              (_) async => const Left(ApiFailure(message: 'Error')));
          return propertyBloc;
        },
        act: (bloc) => bloc.add(LoadProperties()),
        expect: () => [
              PropertyState.initial().copyWith(isLoading: true),
              PropertyState.initial()
                  .copyWith(isLoading: false, error: 'Error'),
            ],
        verify: (_) {
          verify(() => getAllPropertyUsecase.call()).called(1);
        });
  });
}
