import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/features/comments/domain/usecase/cmments_usecases.dart';
import 'comments_event.dart';
import 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetCommentsUseCase getComments;
  final AddCommentUseCase addComment;

  CommentsBloc({required this.getComments, required this.addComment}) : super(CommentsInitial()) {
    on<FetchComments>(onFetchComments);
    on<PostComment>(onPostComment);
  }

  Future<void> onFetchComments(FetchComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    final result = await getComments(event.newsId);
    result.fold(
      (failure) => emit(CommentsError(failure.message)),
      (comments) => emit(CommentsLoaded(comments)),
    );
  }

  Future<void> onPostComment(PostComment event, Emitter<CommentsState> emit) async {
    final result = await addComment(event.newsId, event.commentText);
    result.fold(
      (failure) => emit(CommentsError(failure.message)),
      (_) => add(FetchComments(event.newsId)), // Refresh comments after posting
    );
  }
}
