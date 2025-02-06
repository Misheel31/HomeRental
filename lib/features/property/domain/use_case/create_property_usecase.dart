import 'package:dartz/dartz.dart';
import 'package:home_rental/app/usecase/usecase.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/repository/property_repository.dart';

class CreatePropertyParams {
  final String title;
  final String description;
  final String location;
  final String image;
  final String pricePerNight;
  final bool available;
  final int bedCount;
  final int bedroomCount;
  final String city;
  final String state;
  final String country;
  final int guestCount;
  final int bathroomCount;
  final List<String>? amenities;

  const CreatePropertyParams({
    required this.title,
    required this.description,
    required this.location,
    required this.amenities,
    required this.image,
    required this.available,
    required this.country,
    required this.pricePerNight,
    required this.city,
    required this.bathroomCount,
    required this.bedCount,
    required this.bedroomCount,
    required this.guestCount,
    required this.state,
  });
}

class CreatePropertyUseCase
    implements UsecaseWithParams<void, CreatePropertyParams> {
  final IPropertyRepository propertyRepository;

  CreatePropertyUseCase({required this.propertyRepository});

  @override
  Future<Either<Failure, void>> call(CreatePropertyParams params) async {
    try {
      await propertyRepository.createProperty(
        PropertyEntity(
          title: params.title,
          description: params.description,
          location: params.location,
          image: params.image,
          city: params.city,
          state: params.state,
          country: params.country,
          bedCount: params.bedCount,
          bedroomCount: params.bedroomCount,
          bathroomCount: params.bathroomCount,
          guestCount: params.guestCount,
          available: params.available,
          pricePerNight: double.tryParse(params.pricePerNight) ?? 0.0,
          amenities: params.amenities ?? [],
        ),
      );
      return const Right(null);
    } catch (e) {
      return const Left(ApiFailure(message: 'error'));
    }
  }
}
