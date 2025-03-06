import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../view_model/comments_bloc.dart';
import '../view_model/comments_event.dart';
import '../view_model/comments_state.dart';

class CommentsView extends StatefulWidget {
  final String newsId;
  const CommentsView({super.key, required this.newsId});

  @override
  CommentsViewState createState() => CommentsViewState();
}

class CommentsViewState extends State<CommentsView> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommentsBloc>().add(FetchComments(widget.newsId));
  }

  void _postComment() {
    final commentText = _commentController.text.trim();
    if (commentText.isNotEmpty) {
      context.read<CommentsBloc>().add(PostComment(widget.newsId, commentText));
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CommentsBloc, CommentsState>(
              builder: (context, state) {
                if (state is CommentsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CommentsLoaded) {
                  return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      final comment = state.comments[index];
                      return ListTile(
                        title: Text(comment.username),
                        subtitle: Text(comment.text),
                      );
                    },
                  );
                } else if (state is CommentsError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No Comments Yet'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(hintText: 'Add a comment...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _postComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
