import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/entity/auth_entity.dart';
import 'package:uni_football_app/features/auth/domain/repository/auth_repository.dart';
import 'package:uni_football_app/features/auth/domain/usecase/register_user_usecase.dart';

// Mock repository class
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Register fallback values for AuthEntity and other types as needed
  registerFallbackValue(const AuthEntity(
    userId: 'defaultUserId', // Optional field
    fullName: 'Default User', // ✅ Required field added
    email: 'default@example.com',
    username: 'defaultUser',
    password: 'defaultPassword',
    image: null, // ✅ Keeping image as nullable
  ));

  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase registerUseCase;

  const tFullName = 'Test User'; // ✅ Required field
  const tUsername = 'testUser';
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tImage = null; // ✅ Image is nullable

// ✅ Register UseCase Params (Matching AuthEntity)
  const tParams = RegisterUserParams(
    // Optional (include if used in params)
    fullname: tFullName, // ✅ Now included
    username: tUsername,
    email: tEmail,
    password: tPassword,
    image: tImage, // ✅ Explicitly set as nullable
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  // Test 1: Should call repository to register a user
  test('should call repository to register a user', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    await registerUseCase(tParams);

    // Assert
    verify(() => mockAuthRepository.registerUser(any()))
        .called(1); // Verify repository call
  });

  // Test 2: Should return successful result
  test('should return successful result', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, const Right(null)); // Expecting success
  });

  // Test 3: Should return successful result when params are correct
  test('should return success with correct params', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, const Right(null)); // Expecting success
  });

  // Test 4: Should return successful result when user is registered
  test('should return success when user is registered', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, const Right(null)); // Expecting success
  });
}
