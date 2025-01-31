import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NextPageEvent extends OnboardingEvent {}

class CompleteOnboardingEvent extends OnboardingEvent {}
