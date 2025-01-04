import 'package:music_app/Models/comment_model.dart';

class User {
  final String id;
  final String username;
  final String? email;
  final String? profilePicture;
  final List<dynamic>? likedSongs;
  final List<dynamic>? likedPosts;
  final List<Comment>? comments;
  final List<dynamic>? secretGifts;

  User({
    required this.id,
    required this.username,
    this.email,
    this.profilePicture,
    this.likedSongs,
    this.likedPosts,
    this.comments,
    this.secretGifts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];
    List<String> likes = [];
    return User(
      id: json['_id'],
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      profilePicture: json['profilePicture'] ?? "",
      likedSongs: List<String>.from(json['likedSongs']) ?? likes,
      likedPosts: List<String>.from(json['likedPosts']) ?? likes,
      comments:
          (json['comments'] as List).map((e) => Comment.fromJson(e)).toList() ??
              comments,
      secretGifts: List<String>.from(json['secretGifts'] ?? likes),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profilePicture': profilePicture,
      'likedSongs': likedSongs,
      'likedPosts': likedPosts,
      'comments': comments!.map((e) => e.toJson()).toList(),
      'secretGifts': secretGifts,
    };
  }
}
