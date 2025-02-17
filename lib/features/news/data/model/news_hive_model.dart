import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entity/news_entity.dart';

part 'news_hive_model.g.dart';

@HiveType(typeId: 1) // Use appropriate ID
class NewsHiveModel extends Equatable {
  @HiveField(0)
  final String newsId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final String? newsImage;
  @HiveField(4)
  final String author;
  @HiveField(5)
  final String datePublished;

  const NewsHiveModel({
    required this.newsId,
    required this.title,
    required this.body,
    this.newsImage,
    required this.author,
    required this.datePublished,
  });

  factory NewsHiveModel.fromEntity(NewsEntity entity) {
    return NewsHiveModel(
      newsId: entity.newsId,
      title: entity.title,
      body: entity.body,
      newsImage: entity.newsImage,
      author: entity.author,
      datePublished: entity.datePublished.toIso8601String(),
    );
  }

  NewsEntity toEntity() {
    return NewsEntity(
      newsId: newsId,
      title: title,
      body: body,
      newsImage: newsImage,
      author: author,
      datePublished: DateTime.parse(datePublished),
    );
  }

  @override
  List<Object?> get props =>
      [newsId, title, body, newsImage, author, datePublished];
}
