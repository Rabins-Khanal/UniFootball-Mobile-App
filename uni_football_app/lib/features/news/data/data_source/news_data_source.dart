import '../../domain/entity/news_entity.dart';

abstract interface class INewsDataSource {
  Future<List<NewsEntity>> getNewsOverview(); // To fetch list of news overview
  Future<NewsEntity> getNewsDetails(
      String newsId); // To fetch detailed news by ID
}
