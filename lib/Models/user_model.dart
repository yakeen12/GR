import 'package:music_app/Models/comment_model.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String? profilePicture;
  final List<String> likedSongs;
  final List<String> likedPosts;
  final List<Comment> comments;
  final List<String> secretGifts;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profilePicture,
    required this.likedSongs,
    required this.likedPosts,
    required this.comments,
    required this.secretGifts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      likedSongs: List<String>.from(json['likedSongs'] ?? []),
      likedPosts: List<String>.from(json['likedPosts'] ?? []),
      comments:
          (json['comments'] as List).map((e) => Comment.fromJson(e)).toList(),
      secretGifts: List<String>.from(json['secretGifts'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'likedSongs': likedSongs,
      'likedPosts': likedPosts,
      'comments': comments.map((e) => e.toJson()).toList(),
      'secretGifts': secretGifts,
    };
  }
}
