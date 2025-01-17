import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/teams_entity.dart';

part 'teams_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.teamsTableId)
class TeamsHiveModel extends Equatable {
  @HiveField(0)
  final String? teamsId;
  @HiveField(1)
  final String teamsName;

  TeamsHiveModel({
    String? teamsId,
    required this.teamsName,
  }) : teamsId = teamsId ?? const Uuid().v4();

  // Initail Constructor
  const TeamsHiveModel.initial()
      : teamsId = '',
        teamsName = '';

  // From Entity
  factory TeamsHiveModel.fromEntity(TeamsEntity entity) {
    return TeamsHiveModel(
      teamsId: entity.teamsId,
      teamsName: entity.teamsName,
    );
  }

  // To Entity
  TeamsEntity toEntity() {
    return TeamsEntity(
      teamsId: teamsId,
      teamsName: teamsName,
    );
  }

  @override
  List<Object?> get props => [teamsId, teamsName];
}

// // // From Entity List
// // static List<BatchHiveModel> fromEntityList(List<BatchEntity> entityList) {
// //   return entityList
// //       .map((entity) => BatchHiveModel.fromEntity(entity))
// //       .toList();
// // }

// // To Entity List
// static List<BatchEntity> toEntityList(List<BatchHiveModel> hiveList) {
//   return hiveList.map((hive) => hive.toEntity()).toList();
// }
