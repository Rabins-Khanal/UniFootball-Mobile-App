import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/usecase/login_usecase.dart';

import '../repository/repository.mock.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  const testUsername = 'Rabins';
  const testPassword = 'hello';
  const testToken = 'mocked_token';

  const loginParams =
      LoginParams(username: testUsername, password: testPassword);

  test('should return token on successful login', () async {
    // Arrange
    when(() => mockAuthRepository.loginUser(testUsername, testPassword))
        .thenAnswer((_) async => const Right(testToken));

    // Act
    final result = await loginUseCase(loginParams);

    // Assert
    expect(result, const Right(testToken));
    verify(() => mockAuthRepository.loginUser(testUsername, testPassword))
        .called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
