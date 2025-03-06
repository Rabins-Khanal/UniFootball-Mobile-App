class CommentEntity {
  final String id;
  final String newsId;
  final String username;
  final String text;
  final DateTime timestamp;

  CommentEntity({
    required this.id,
    required this.newsId,
    required this.username,
    required this.text,
    required this.timestamp,
  });
}
