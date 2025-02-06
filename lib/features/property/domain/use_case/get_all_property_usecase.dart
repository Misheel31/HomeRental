import 'package:dartz/dartz.dart';
import 'package:home_rental/app/usecase/usecase.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';
import 'package:home_rental/features/property/domain/repository/property_repository.dart';

class GetAllPropertyUsecase
    implements UsecaseWithoutParams<List<PropertyEntity>> {
  final IPropertyRepository propertyRepository;

  GetAllPropertyUsecase({required this.propertyRepository});

  @override
  Future<Either<Failure, List<PropertyEntity>>> call() {
    return propertyRepository.getAllProperties();
  }
}
