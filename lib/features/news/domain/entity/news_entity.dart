import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String newsId; // This should be your unique identifier.
  final String title;
  final String body;
  final String? newsImage;
  final String author;
  final DateTime datePublished;

  const NewsEntity({
    required this.newsId,
    required this.title,
    required this.body,
    this.newsImage,
    required this.author,
    required this.datePublished,
  });

  @override
  List<Object?> get props => [title, body, newsImage, author, datePublished];
}
