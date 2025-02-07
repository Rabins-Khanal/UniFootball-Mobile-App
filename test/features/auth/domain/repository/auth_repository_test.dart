import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/entity/auth_entity.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  group('AuthRepository Tests', () {
    test('should register user successfully', () async {
      // Arrange
      const AuthEntity user = AuthEntity(
          email: 'test@test.com',
          password: 'password',
          username: 'testuser',
          fullName: 'Test User',
          image: 'image_url');
      when(() => mockAuthRepository.registerUser(user))
          .thenAnswer((_) async => const Right(unit));

      // Act
      final result = await mockAuthRepository.registerUser(user);

      // Assert
      expect(result, const Right(unit));
      verify(() => mockAuthRepository.registerUser(user)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should login user successfully', () async {
      // Arrange
      const String email = 'test@test.com';
      const String password = 'password';
      when(() => mockAuthRepository.loginUser(email, password))
          .thenAnswer((_) async => const Right('token'));

      // Act
      final result = await mockAuthRepository.loginUser(email, password);

      // Assert
      expect(result, const Right('token'));
      verify(() => mockAuthRepository.loginUser(email, password)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return current user successfully', () async {
      // Arrange
      const AuthEntity user = AuthEntity(
          email: 'test@test.com',
          password: 'password',
          username: 'testuser',
          fullName: 'Test User',
          image: 'image_url');
      when(() => mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(user));

      // Act
      final result = await mockAuthRepository.getCurrentUser();

      // Assert
      expect(result, const Right(user));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
