import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';

import '../../domain/entity/news_entity.dart';
import '../../domain/repository/news_repository.dart';
import '../data_source/news_local_datasource/news_local_datasource.dart';

class NewsLocalRepository implements INewsRepository {
  final NewsLocalDataSource _newsLocalDataSource;

  NewsLocalRepository(this._newsLocalDataSource);

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsOverview() async {
    try {
      final localNews = await _newsLocalDataSource.getNewsOverview();
      return Right(localNews);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error fetching local news overview: $e"));
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> getNewsDetails(String newsId) async {
    try {
      final localNews = await _newsLocalDataSource.getNewsDetails(newsId);
      return Right(localNews);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error fetching local news details: $e"));
    }
  }

  // Optionally, you could add a method for saving news to local storage
  Future<void> saveNews(List<NewsEntity> news) async {
    try {
      await _newsLocalDataSource.saveNews(news);
    } catch (e) {
      throw Exception("Error saving news to local storage: $e");
    }
  }
}
