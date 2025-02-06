import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/property/domain/use_case/delete_property_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late DeletePropertyUsecase usecase;
  late MockPropertyRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;

  setUp(() {
    repository = MockPropertyRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = DeletePropertyUsecase(
        propertyRepository: repository, tokenSharedPrefs: tokenSharedPrefs);
  });
  const tPropertyId = '1';
  const token = 'token';
  const deletePropertyParams = DeletePropertyParams(propertyId: tPropertyId);

  test('delete property using id', () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));
    when(() => repository.deleteProperty(any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(deletePropertyParams);

    expect(result, const Right(null));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verify(() => repository.deleteProperty(tPropertyId, token)).called(1);

    verifyNoMoreInteractions(repository);

    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  test('delete property using id and check weather the id is property1',
      () async {
    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => const Right(token));

    when(() => repository.deleteProperty(any(), any()))
        .thenAnswer((invocation) async {
      final propertyId = invocation.positionalArguments[0] as String;

      if (propertyId == 'property1') {
        return const Right(null);
      } else {
        return const Left(ApiFailure(message: 'Property not found'));
      }
    });

    final result =
        await usecase(const DeletePropertyParams(propertyId: 'property1'));
    expect(result, const Right(null));

    verify(() => tokenSharedPrefs.getToken()).called(1);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });
}
