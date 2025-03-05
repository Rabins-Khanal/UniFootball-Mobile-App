import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_football_app/features/onboarding/presentation/view/onboarding_view.dart';

import '../../../auth/presentation/view/login_view.dart';
import '../../../auth/presentation/view_model/login/login_bloc.dart';


class SplashCubit extends Cubit<void> {
  SplashCubit(this._loginBloc) : super(null);

  final LoginBloc _loginBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final bool hasSeenOnboarding =
          prefs.getBool('hasSeenOnboarding') ?? false;

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => hasSeenOnboarding
                ? BlocProvider.value(
                    value: _loginBloc,
                    child: LoginView(),
                  )
                : OnboardingView(),
          ),
        );
        if (!hasSeenOnboarding) {
          await prefs.setBool('hasSeenOnboarding', true);
        }
      }
    });
  }
}
