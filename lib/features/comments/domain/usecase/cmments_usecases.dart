import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/comments/domain/entity/entity.dart';
import 'package:uni_football_app/features/comments/domain/repository/comments_repository.dart';

class GetCommentsUseCase {
  final CommentsRepository repository;

  GetCommentsUseCase(this.repository);

  Future<Either<Failure, List<CommentEntity>>> call(String newsId) async {
    return await repository.getComments(newsId);
  }
}

class AddCommentUseCase {
  final CommentsRepository repository;

  AddCommentUseCase(this.repository);

  Future<Either<Failure, void>> call(String newsId, String commentText) async {
    return await repository.addComment(newsId, commentText);
  }
}
