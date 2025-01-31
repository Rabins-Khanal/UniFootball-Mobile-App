import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc()
      : super(const OnboardingState(currentPage: 0, isCompleted: false)) {
    on<NextPageEvent>((event, emit) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    });

    on<CompleteOnboardingEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);
      emit(state.copyWith(isCompleted: true));
    });
  }
}
