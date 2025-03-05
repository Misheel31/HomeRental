import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/booking/domain/entity/booking_entity.dart';
import 'package:home_rental/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:home_rental/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateBookingUsecase extends Mock implements CreateBookingUsecase {}

class FakeCreateBookingParams extends Fake implements CreateBookingParams {}

void main() {
  late BookingBloc bookingBloc;
  late MockCreateBookingUsecase mockCreateBookingUsecase;

  setUpAll(() {
    registerFallbackValue(FakeCreateBookingParams());
  });

  setUp(() {
    mockCreateBookingUsecase = MockCreateBookingUsecase();
    bookingBloc = BookingBloc(createBookingUsecase: mockCreateBookingUsecase);
  });

  tearDown(() {
    bookingBloc.close();
  });

  group('BookingBloc', () {
    const bookingEntity = BookingEntity(
      username: 'testUser',
      startDate: '2025-02-16',
      endDate: '2025-02-17',
      totalPrice: '100.0',
      propertyId: '1',
    );

    test('initial state is correct', () {
      expect(bookingBloc.state, BookingState.initial());
    });

    blocTest<BookingBloc, BookingState>(
      'emits [isLoading, success] when AddBooking is added and use case is successful',
      build: () {
        when(() => mockCreateBookingUsecase.call(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bookingBloc;
      },
      act: (bloc) => bloc.add(const AddBooking(bookingEntity)),
      expect: () => [
        const BookingState(booking: [], isLoading: true),
        const BookingState(booking: [], isLoading: false),
      ],
    );
    blocTest<BookingBloc, BookingState>(
      'emits [isLoading, error] when AddBooking is added and use case fails',
      build: () {
        when(() => mockCreateBookingUsecase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Error message')),
        );
        return bookingBloc;
      },
      act: (bloc) => bloc.add(const AddBooking(bookingEntity)),
      expect: () => [
        const BookingState(booking: [], isLoading: true),
        const BookingState(
            booking: [], isLoading: false, error: null),
      ],
    );
  });
}
