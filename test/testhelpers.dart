import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uni_football_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:uni_football_app/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:uni_football_app/features/home/presentation/view_model/home_cubit.dart';

// Mock classes for dependencies

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockRegisterBloc extends Mock implements RegisterBloc {}

// Mock for BuildContext
class MockBuildContext extends Mock implements BuildContext {}

// Mock for NavigatorObserver
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Register fallback value for LoginParams (to avoid errors when using `any`)
class MockLoginParams extends Mock implements LoginParams {}

void setup() {
  registerFallbackValue(LoginParams(username: 'test', password: 'password'));
}
