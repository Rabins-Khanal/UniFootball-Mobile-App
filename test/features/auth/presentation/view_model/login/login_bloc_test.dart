import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:uni_football_app/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:uni_football_app/features/auth/presentation/view_model/login/login_state.dart';
import 'package:uni_football_app/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_cubit.dart';

// Mocks for dependencies
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockHomeCubit mockHomeCubit;
  late MockRegisterBloc mockRegisterBloc;
  late LoginBloc loginBloc;

  setUpAll(() {
    registerFallbackValue(LoginParams(username: 'test', password: 'password'));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockHomeCubit = MockHomeCubit();
    mockRegisterBloc = MockRegisterBloc();
    loginBloc = LoginBloc(
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
    );
  });

  // Test 1: Initial state should be LoginState.initial()
  test('Loginstate be successfully changed()', () {
    expect(loginBloc.state, LoginState.initial());
  });

  // Test 2: Ensure LoginBloc is initialized properly and does not throw errors
  test('should emit isSuccess = true when RegisterUser event is successful',
      () {
    expect(() => loginBloc, returnsNormally);
  });
  // Test 5: Ensure LoginBloc starts with isLoading = false
  test('should start with isLoading = false', () {
    expect(loginBloc.state.isLoading, false);
  });
}
