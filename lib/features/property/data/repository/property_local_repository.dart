import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/data/data_source/local_datasource/property_local_datasource.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/repository/property_repository.dart';

class PropertyLocalRepository implements IPropertyRepository {
  final PropertyLocalDatasource _propertyLocalDatasource;

  PropertyLocalRepository(
      {required PropertyLocalDatasource propertyLocalDataSource})
      : _propertyLocalDatasource = propertyLocalDataSource;

  @override
  Future<Either<Failure, void>> createProperty(PropertyEntity property) {
    try {
      _propertyLocalDatasource.createProperty(property);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProperty(String id, String? token) {
    try {
      _propertyLocalDatasource.deleteProperty(id, token);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<PropertyEntity>>> getAllProperties() async {
    try {
      return _propertyLocalDatasource.getAllProperties(
          title: '',
          description: '',
          location: '',
          image: '',
          pricePerNight: 0.0,
          bedCount: 0,
          bedroomCount: 0,
          city: '',
          state: '',
          country: '',
          guestCount: 0,
          bathroomCount: 0,
          amenities: []).then((value) {
        return Right(value);
      });
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> updateProperty(PropertyEntity property) {
    throw UnimplementedError();
  }
}
