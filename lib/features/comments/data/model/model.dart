
import 'package:uni_football_app/features/comments/domain/entity/entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required String id,
    required String newsId,
    required String username,
    required String text,
    required DateTime timestamp,
  }) : super(id: id, newsId: newsId, username: username, text: text, timestamp: timestamp);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      newsId: json['newsId'],
      username: json['username'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'newsId': newsId,
      'username': username,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
