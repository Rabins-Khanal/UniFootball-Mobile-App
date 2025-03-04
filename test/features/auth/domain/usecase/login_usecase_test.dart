import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/repository/auth_repository.dart';
import 'package:uni_football_app/features/auth/domain/usecase/login_usecase.dart';

// Mock Repository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUpAll(() {
    // Register fallback value for LoginParams
    registerFallbackValue(LoginParams(username: 'test', password: 'password'));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  // 1. LoginUseCase - Success Test
  test('should return token when login is successful', () async {
    // Arrange: Mocking the repository to return a success response
    final params = LoginParams(username: 'test', password: 'password');
    when(() => mockAuthRepository.loginUser(any(), any()))
        .thenAnswer((_) async => Right('token'));

    // Act: Call the use case
    final result = await loginUseCase(params);

    // Assert: Check that the result is the expected token
    expect(result, Right('token'));
    verify(() => mockAuthRepository.loginUser(
        'test', 'password')); // Verifying repository interaction
  });
}
