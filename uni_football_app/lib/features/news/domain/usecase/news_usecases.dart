import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/news_entity.dart';
import '../repository/news_repository.dart';

// Use case for fetching news overview
class GetNewsOverviewUseCase {
  final INewsRepository repository;

  GetNewsOverviewUseCase(this.repository);

  Future<Either<Failure, List<NewsEntity>>> call() {
    return repository.getNewsOverview();
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
