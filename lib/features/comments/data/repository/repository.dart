
import 'package:dartz/dartz.dart';
import 'package:uni_football_app/core/error/failure.dart';
import 'package:uni_football_app/features/comments/data/comment_data_source/comments_remote_data_source.dart';
import 'package:uni_football_app/features/comments/domain/entity/entity.dart';
import 'package:uni_football_app/features/comments/domain/repository/comments_repository.dart';


class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource remoteDataSource;

  CommentsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String newsId) async {
    try {
      final comments = await remoteDataSource.fetchComments(newsId);
      return Right(comments);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addComment(String newsId, String commentText) async {
    try {
      await remoteDataSource.postComment(newsId, commentText);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure());
    }
  }
}
