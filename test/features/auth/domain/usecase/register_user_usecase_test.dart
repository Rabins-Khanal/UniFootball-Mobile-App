import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/auth/domain/entity/auth_entity.dart';
import 'package:uni_football_app/features/auth/domain/usecase/register_user_usecase.dart';

import '../repository/repository.mock.dart';

void main() {
  late RegisterUseCase registerUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  const testEmail = 'test@example.com';
  const testUsername = 'testuser';
  const testPassword = 'password123';
  const fullName = 'fullName123';

  const registerParams = RegisterUserParams(
    email: testEmail,
    username: testUsername,
    password: testPassword,
    fullname: fullName,
  );

  const authEntity = AuthEntity(
    email: testEmail,
    username: testUsername,
    password: testPassword,
    fullName: fullName,
  );

  test('should register user successfully', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(authEntity))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await registerUseCase(registerParams);

    // Assert
    expect(result, const Right(unit));
    verify(() => mockAuthRepository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure if registration fails', () async {
    // Arrange
    const errorMessage = 'Registration failed';
    when(() => mockAuthRepository.registerUser(authEntity))
        .thenAnswer((_) async => const Left(ApiFailure(message: errorMessage)));

    // Act
    final result = await registerUseCase(registerParams);

    // Assert
    expect(result, isA<Left<Failure, void>>());
    final failure = (result as Left<Failure, void>).value;
    expect(failure, isA<ApiFailure>());
    expect(failure.message, errorMessage);

    verify(() => mockAuthRepository.registerUser(authEntity)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
