import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/models/user_model.dart';

class Post {
  final String id;
  final String content;
  final User user;
  final Song? song;
  final Episode? episode;
  final String community;
  final List<dynamic> likes;
  final List<dynamic> comments;
  final bool hasLiked;

  Post({
    required this.id,
    required this.content,
    required this.user,
    required this.hasLiked,
    this.song,
    this.episode,
    required this.community,
    required this.likes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    // List<String> dummy = [];
    return Post(
      id: json['_id'],
      content: json['content'],
      user: User.fromJson(json['user']),
      song: Song.fromJson(json['song']),
      episode: Episode.fromJson(json['episode']),
      community: json['community'],
      likes: List<dynamic>.from(json['likes']),
      hasLiked: json['hasLiked'],
      comments: List<dynamic>.from(json['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'user': user,
      'song': song,
      'podcast': episode,
      'community': community,
      'likes': likes,
      'comments': comments,
    };
  }
}
