import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:home_rental/features/booking/domain/repository/booking_repository.dart';
import 'package:home_rental/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingRepository extends Mock implements IBookingRepository {}

void main() {
  late CreateBookingUsecase usecase;
  late MockBookingRepository mockBookingRepository;

  setUp(() {
    mockBookingRepository = MockBookingRepository();
    usecase = CreateBookingUsecase(bookingRepository: mockBookingRepository);
  });

  const tUsername = 'john_doe';
  const tStartDate = '2025-02-01';
  const tEndDate = '2025-02-10';
  const tTotalPrice = '500.00';
  const tPropertyId = 'property_123';
  const tBookingParams = CreateBookingParams(
    username: tUsername,
    startDate: tStartDate,
    endDate: tEndDate,
    totalPrice: tTotalPrice,
    propertyId: tPropertyId,
  );
  const tBookingEntity = BookingEntity(
    username: tUsername,
    startDate: tStartDate,
    endDate: tEndDate,
    totalPrice: tTotalPrice,
    propertyId: tPropertyId,
  );

  group('CreateBookingUsecase', () {
    test('should call createBooking on repository with correct parameters',
        () async {
      when(() => mockBookingRepository.createBooking(tBookingEntity))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      final result = await usecase(tBookingParams);

      verify(() => mockBookingRepository.createBooking(tBookingEntity))
          .called(1);

      expect(result, const Right<Failure, void>(null));
    });

    test('should return failure when repository returns failure', () async {
      when(() => mockBookingRepository.createBooking(tBookingEntity))
          .thenAnswer((_) async => const Left<Failure, void>(
              ApiFailure(message: 'Booking creation failed')));

      final result = await usecase(tBookingParams);

      expect(
          result,
          const Left<Failure, void>(
              ApiFailure(message: 'Booking creation failed')));

      verify(() => mockBookingRepository.createBooking(tBookingEntity))
          .called(1);
    });
  });
}
