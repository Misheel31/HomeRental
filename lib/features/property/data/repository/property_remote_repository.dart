import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:home_rental/features/property/data/data_source/remote_datasource/property_remote_datasource.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/repository/property_repository.dart';

class PropertyRemoteRepository implements IPropertyRepository {
  final PropertyRemoteDatasource remoteDataSource;

  PropertyRemoteRepository(AuthRemoteDataSource authRemoteDataSource,
      {required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createProperty(PropertyEntity property) async {
    try {
      remoteDataSource.createProperty(property);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProperty(String id, String? token) async {
    try {
      remoteDataSource.deleteProperty(id, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PropertyEntity>>> getAllProperties() async {
    try {
      final propertyList = await remoteDataSource.getAllProperties(
        title: '',
        description: '',
        location: '',
        image: '',
        pricePerNight: 0,
        bedCount: 0,
        bedroomCount: 0,
        city: '',
        state: '',
        country: '',
        guestCount: 0,
        bathroomCount: 0,
        amenities: [],
      );

      final propertyEntities = propertyList.map((property) {
        return PropertyEntity(
          id: property.id ?? '',
          title: property.title,
          description: property.description,
          location: property.location,
          image: property.image,
          pricePerNight: property.pricePerNight,
          available: property.available,
          bedCount: property.bedCount,
          bedroomCount: property.bedroomCount,
          city: property.city,
          state: property.state,
          country: property.country,
          amenities: property.amenities,
          bathroomCount: property.bathroomCount,
          guestCount: property.guestCount,
        );
      }).toList();

      return Right(propertyEntities);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PropertyEntity>>> updateProperty(
      PropertyEntity property) {
    // TODO: implement updateProperty
    throw UnimplementedError();
  }
}
