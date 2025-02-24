import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/app/shared_prefs/token_shared_prefs.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/domain/repository/booking_repository.dart';
import 'package:home_rental/features/booking/domain/use_case/delete_booking_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepository extends Mock implements IBookingRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late DeleteBookingUsecase usecase;
  late MockBookingRepository mockBookingRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockBookingRepository = MockBookingRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = DeleteBookingUsecase(
      bookingRepository: mockBookingRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  const bookingId = 'booking123';
  const token = 'testToken';
  const params = DeleteBookingParams(bookingId: bookingId);

  group('DeleteBookingUsecase', () {
    test('should return failure if token retrieval fails', () async {
      // Arrange
      when(() => mockTokenSharedPrefs.getToken()).thenAnswer(
        (_) async => const Left(ApiFailure(message: 'Token error')),
      );

      // Act
      final result = await usecase.call(params);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ApiFailure>()),
        (_) => fail('Expected failure'),
      );
    });

    test('should call deleteBooking with correct params when token is valid',
        () async {
      when(() => mockTokenSharedPrefs.getToken()).thenAnswer(
        (_) async => const Right(token),
      );
      when(() => mockBookingRepository.deleteBooking(bookingId, token))
          .thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase.call(params);

      expect(result.isRight(), true);
      verify(() => mockBookingRepository.deleteBooking(bookingId, token))
          .called(1);
    });

    test('should return failure if deleteBooking fails', () async {
      when(() => mockTokenSharedPrefs.getToken()).thenAnswer(
        (_) async => const Right(token),
      );
      when(() => mockBookingRepository.deleteBooking(bookingId, token))
          .thenAnswer(
        (_) async =>
            const Left(ApiFailure(message: 'Failed to delete booking')),
      );
      final result = await usecase.call(params);

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ApiFailure>()),
        (_) => fail('Expected failure'),
      );
    });
  });
}
