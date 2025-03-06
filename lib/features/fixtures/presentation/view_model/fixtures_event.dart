import 'package:equatable/equatable.dart';

abstract class FixturesEvent extends Equatable {
  const FixturesEvent();
  @override
  List<Object> get props => [];
}

class FetchFixtures extends FixturesEvent {}
