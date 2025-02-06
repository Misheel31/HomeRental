import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_rental/app/shared_prefs/token_shared_prefs.dart';
import 'package:home_rental/app/usecase/usecase.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/domain/repository/property_repository.dart';

class DeletePropertyParams extends Equatable {
  final String propertyId;

  const DeletePropertyParams({required this.propertyId});

  const DeletePropertyParams.empty() : propertyId = '_empty.String';

  @override
  List<Object?> get props => [propertyId];
}

class DeletePropertyUsecase
    implements UsecaseWithParams<void, DeletePropertyParams> {
  final IPropertyRepository propertyRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeletePropertyUsecase({
    required this.propertyRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeletePropertyParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await propertyRepository.deleteProperty(params.propertyId, r);
    });
  }
}
