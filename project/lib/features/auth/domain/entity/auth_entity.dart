import 'package:equatable/equatable.dart';

import '../../../teams/domain/entity/teams_entity.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String lName;
  final String? image;
  final String phone;
  final TeamsEntity teams;
  final String username;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.teams,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fName, lName, image, teams, phone, username, password];
}
