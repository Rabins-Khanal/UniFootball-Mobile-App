// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeamsHiveModelAdapter extends TypeAdapter<TeamsHiveModel> {
  @override
  final int typeId = 1;

  @override
  TeamsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamsHiveModel(
      teamsId: fields[0] as String?,
      teamsName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TeamsHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.teamsId)
      ..writeByte(1)
      ..write(obj.teamsName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
