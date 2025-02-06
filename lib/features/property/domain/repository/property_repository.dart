import 'package:dartz/dartz.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';

abstract interface class IPropertyRepository {
  Future<Either<Failure, List<PropertyEntity>>> getAllProperties();
  Future<Either<Failure, void>> createProperty(PropertyEntity property);
  Future<Either<Failure, void>> updateProperty(PropertyEntity property);
  Future<Either<Failure, void>> deleteProperty(String id, String? token);
}
