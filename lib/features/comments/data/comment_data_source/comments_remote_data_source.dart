import 'package:uni_football_app/features/comments/data/model/model.dart';


abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> fetchComments(String newsId);
  Future<void> postComment(String newsId, String commentText);
}

class CommentsRemoteDataSourceImpl implements CommentsRemoteDataSource {
  final List<CommentModel> _mockComments = [];

  @override
  Future<List<CommentModel>> fetchComments(String newsId) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulating network delay
    return _mockComments.where((comment) => comment.newsId == newsId).toList();
  }

  @override
  Future<void> postComment(String newsId, String commentText) async {
    _mockComments.add(CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      newsId: newsId,
      username: "User", // This should be dynamic
      text: commentText,
      timestamp: DateTime.now(),
    ));
  }
}
