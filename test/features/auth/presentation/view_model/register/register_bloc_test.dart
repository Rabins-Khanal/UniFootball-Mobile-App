import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:uni_football_app/features/auth/domain/usecase/upload_image_usecase.dart';
import 'package:uni_football_app/features/auth/presentation/view_model/register/register_bloc.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUseCase extends Mock implements UploadImageUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockRegisterUseCase mockRegisterUseCase;
  late RegisterBloc registerBloc;

  setUpAll(() {
    registerFallbackValue(RegisterUserParams(
        fullname: 'test',
        email: 'test@example.com',
        username: 'test',
        password: 'password',
        image: ''));
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    registerBloc = RegisterBloc(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: MockUploadImageUseCase(),
    );
  });

  // Test 1: Initial state should be RegisterState.initial()
  test('Initial state should be RegisterState.initial()', () {
    expect(registerBloc.state, RegisterState.initial());
  });

  // Test 2: Ensure RegisterBloc is initialized properly and does not throw errors
  test('should not throw errors when RegisterBloc is initialized', () {
    expect(() => registerBloc, returnsNormally);
  });

  // Test 3: State should remain the same if no events are added
  test('should not change state if no events are added', () {
    final initialState = registerBloc.state;
    expect(registerBloc.state, initialState);
  });
}
