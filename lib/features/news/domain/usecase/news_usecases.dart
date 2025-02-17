import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/news/domain/entity/news_entity.dart';
import 'package:uni_football_app/features/news/domain/repository/news_repository.dart';

class GetNewsOverviewUseCase {
  final INewsRepository repository;

  GetNewsOverviewUseCase(this.repository);

  Future<Either<Failure, List<NewsEntity>>> call() async {
    final result = await repository.getNewsOverview();
    return result;
  }
}

// Use case for fetching full news details
class GetNewsDetailsUseCase {
  final INewsRepository repository;

  GetNewsDetailsUseCase(this.repository);

  Future<Either<Failure, NewsEntity>> call(String newsId) {
    return repository.getNewsDetails(newsId);
  }
}
