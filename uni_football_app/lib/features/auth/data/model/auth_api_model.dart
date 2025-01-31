import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fullname;
  final String? image;
  final String email;
  final String username;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fullname,
    required this.image,
    required this.email,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fullName: fullname,
      image: image,
      email: email,
      username: username,
      password: password ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullname: entity.fullName,
      image: entity.image,
      email: entity.email,
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [id, fullname, image, email, username, password];
}
