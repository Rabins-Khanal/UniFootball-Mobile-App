import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/news_entity.dart';

abstract class INewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNewsOverview();
  Future<Either<Failure, NewsEntity>> getNewsDetails(String newsId);
}
