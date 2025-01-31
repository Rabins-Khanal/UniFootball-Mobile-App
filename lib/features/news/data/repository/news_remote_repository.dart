import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/news_entity.dart';
import '../../domain/repository/news_repository.dart';
import '../data_source/news_remote_datasource/news_remote_datasource.dart';

class NewsRemoteRepository implements INewsRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;

  NewsRemoteRepository(this._newsRemoteDataSource);

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsOverview() async {
    try {
      final remoteNews = await _newsRemoteDataSource.getNewsOverview();
      return Right(remoteNews);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error fetching remote news overview: $e"));
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> getNewsDetails(String newsId) async {
    try {
      final remoteNews = await _newsRemoteDataSource.getNewsDetails(newsId);
      return Right(remoteNews);
    } catch (e) {
      return Left(LocalDatabaseFailure(
          message: "Error fetching remote news details: $e"));
    }
  }

  // Optionally, you could add a method for uploading news or images if necessary
}
