import 'package:equatable/equatable.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
  @override
  List<Object> get props => [];
}

class FetchComments extends CommentsEvent {
  final String newsId;
  const FetchComments(this.newsId);

  @override
  List<Object> get props => [newsId];
}

class PostComment extends CommentsEvent {
  final String newsId;
  final String commentText;
  const PostComment(this.newsId, this.commentText);

  @override
  List<Object> get props => [newsId, commentText];
}
