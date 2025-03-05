import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_rental/core/error/failure.dart';
import 'package:home_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:home_rental/features/profile/domain/use_case/get_current_user_usecase.dart';
import 'package:home_rental/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  late ProfileBloc profileBloc;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

  setUp(() {
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    profileBloc = ProfileBloc(getCurrentUserUseCase: mockGetCurrentUserUseCase);
  });

  tearDown(() {
    profileBloc.close();
  });

  const testUser = AuthEntity(
      username: "testUser", email: "test@example.com", password: '1234567');

  test('Initial state should be ProfileState.initial()', () {
    expect(profileBloc.state, ProfileState.initial());
  });

  blocTest<ProfileBloc, ProfileState>(
    'emits [ProfileState.loading, ProfileState.loaded] when GetCurrentUser is successful',
    build: () {
      when(() => mockGetCurrentUserUseCase())
          .thenAnswer((_) async => const Right(testUser));
      return profileBloc;
    },
    act: (bloc) => bloc.add(const GetCurrentUser()),
    expect: () => [
      ProfileState.initial().copyWith(isLoading: true),
      ProfileState.initial()
          .copyWith(isLoading: false, user: testUser, errorMessage: null),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits [ProfileState.loading, ProfileState.error] when GetCurrentUser fails',
    build: () {
      when(() => mockGetCurrentUserUseCase())
          .thenAnswer((_) async => const Left(ApiFailure(message: 'Server Failure')));
      return profileBloc;
    },
    act: (bloc) => bloc.add(const GetCurrentUser()),
    expect: () => [
      ProfileState.initial().copyWith(isLoading: true), 
      ProfileState.initial().copyWith(
          isLoading: false,
          user: null,
          errorMessage: "Server Failure"), 
    ],
  );
}
