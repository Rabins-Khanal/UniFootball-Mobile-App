import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/news_entity.dart';

part 'news_api_model.g.dart';

@JsonSerializable()
class NewsApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String newsId;
  final String title;
  final String body;
  @JsonKey(name: 'news_image')
  final String? newsImage;
  final String author;
  @JsonKey(name: 'date_published')
  final String datePublished;

  const NewsApiModel({
    required this.newsId,
    required this.title,
    required this.body,
    this.newsImage,
    required this.author,
    required this.datePublished,
  });

  factory NewsApiModel.fromJson(Map<String, dynamic> json) =>
      _$NewsApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiModelToJson(this);

  // To Entity
  NewsEntity toEntity() {
    return NewsEntity(
      newsId: newsId, // Add the newsId here
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
