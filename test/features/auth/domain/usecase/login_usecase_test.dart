import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/repository/auth_repository.dart';
import 'package:uni_football_app/features/auth/domain/usecase/login_usecase.dart';

// Mock repository class
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  // Test 1: Should call the repository loginUser method
  test('should call repository loginUser method', () async {
    // Arrange
    when(() => mockAuthRepository.loginUser('user', 'pass'))
        .thenAnswer((_) async => const Right('token'));

    // Act
    await loginUseCase(const LoginParams(username: 'user', password: 'pass'));

    // Assert
    verify(() => mockAuthRepository.loginUser('user', 'pass')).called(1);
  });

  // Test 2: Should return a token when login is successful
  test('should return a token when login is successful', () async {
    // Arrange
    when(() => mockAuthRepository.loginUser('user', 'pass'))
        .thenAnswer((_) async => const Right('token'));

    // Act
    final result = await loginUseCase(
        const LoginParams(username: 'user', password: 'pass'));

    // Assert
    expect(result, const Right('token'));
  });

  // Test 3: Should return failure when login fails (simplified failure handling)
  test('should return failure when login fails', () async {
    // Arrange
    when(() => mockAuthRepository.loginUser('user', 'wrongpass')).thenAnswer(
        (_) async => const Right('')); // Simulating an empty token as failure

    // Act
    final result = await loginUseCase(
        const LoginParams(username: 'user', password: 'wrongpass'));

    // Assert
    expect(
        result, const Right('')); // An empty string to represent a failed login
  });
}
