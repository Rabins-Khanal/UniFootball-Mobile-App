import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/comments/domain/entity/entity.dart';


abstract class CommentsRepository {
  Future<Either<Failure, List<CommentEntity>>> getComments(String newsId);
  Future<Either<Failure, void>> addComment(String newsId, String commentText);
}
