import 'package:uni_football_app/features/news/domain/entity/news_entity.dart';

final mockNewsList = [
  NewsEntity(
    newsId: '1',
    title: 'Breaking News 1',
    body: 'This is the body of breaking news 1.',
    author: 'Author 1',
    newsImage: 'https://example.com/image1.jpg',
    datePublished: DateTime(2025, 03, 01),
  ),
  NewsEntity(
    newsId: '2',
    title: 'Breaking News 2',
    body: 'This is the body of breaking news 2.',
    author: 'Author 2',
    newsImage: 'https://example.com/image2.jpg',
    datePublished: DateTime(2025, 03, 02),
  ),
];
