// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsApiModel _$NewsApiModelFromJson(Map<String, dynamic> json) => NewsApiModel(
      newsId: json['_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      newsImage: json['news_image'] as String?,
      author: json['author'] as String,
      datePublished: json['date_published'] as String,
    );

Map<String, dynamic> _$NewsApiModelToJson(NewsApiModel instance) =>
    <String, dynamic>{
      '_id': instance.newsId,
      'title': instance.title,
      'body': instance.body,
      'news_image': instance.newsImage,
      'author': instance.author,
      'date_published': instance.datePublished,
    };
