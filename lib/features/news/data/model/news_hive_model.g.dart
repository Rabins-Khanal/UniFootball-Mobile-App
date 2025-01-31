import 'package:hive_flutter/hive_flutter.dart';

import 'news_hive_model.dart'; // Adjust the import based on the file location of your NewsHiveModel

class NewsHiveModelAdapter extends TypeAdapter<NewsHiveModel> {
  @override
  final int typeId =
      1; // Make sure to adjust this typeId to a unique value for NewsHiveModel

  @override
  NewsHiveModel read(BinaryReader reader) {
    final numFields = reader.readByte();
    final fields = <int, dynamic>{
      for (var i = 0; i < numFields; i++) reader.readByte(): reader.read(),
    };
    return NewsHiveModel(
      newsId: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
      newsImage: fields[3] as String?,
      author: fields[4] as String,
      datePublished: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsHiveModel obj) {
    writer
      ..writeByte(6) // Number of fields in your NewsHiveModel
      ..writeByte(0)
      ..write(obj.newsId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.newsImage)
      ..writeByte(4)
      ..write(obj.author)
      ..writeByte(5)
      ..write(obj.datePublished);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
