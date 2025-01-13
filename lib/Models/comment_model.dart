import 'package:music_app/Models/user_model.dart';

class Comment {
  final String id;
  final String postId;
  final User user;
  final String content;
  final String likesCount;
  final bool hasLiked;

  Comment(
      {required this.id,
      required this.postId,
      required this.user,
      required this.content,
      required this.likesCount,
      required this.hasLiked});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['_id'],
        postId: json['post'],
        user: User.fromJson(json['user']),
        content: json['content'],
        likesCount: json['likesCount'],
        hasLiked: json["hasLiked"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'user': user,
      'text': content,
    };
  }
}
