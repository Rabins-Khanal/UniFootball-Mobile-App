import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/auth/domain/usecase/login_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository authRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    authRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(authRepository);
  });

  final params = LoginParams(username: 'testuser', password: 'password123');

  test('should return token on successful login', () async {
    when(() => authRepository.loginUser(any(), any()))
        .thenAnswer((_) async => Right('mock_token'));

    final result = await loginUseCase(params);
    expect(result, Right('mock_token'));
    verify(() => authRepository.loginUser(params.username, params.password))
        .called(1);
  });

  test('should return ApiFailure on login error', () async {
    when(() => authRepository.loginUser(any(), any())).thenAnswer((_) async =>
        Left(ApiFailure(message: 'Login failed', statusCode: 401)));

    final result = await loginUseCase(params);
    expect(result, Left(ApiFailure(message: 'Login failed', statusCode: 401)));
    verify(() => authRepository.loginUser(params.username, params.password))
        .called(1);
  });
}
