import 'package:music_app/Models/artist_model.dart';

class Song {
  final String id;
  final String title;
  final Artist artist;
  final String? genre;
  final String url;
  final String img;

  final List<String> likes;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    this.genre,
    required this.url,
    required this.img,
    required this.likes,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'],
      title: json['title'],
      artist: Artist.fromJson(json['artist']),
      genre: json['genre'] ?? "",
      url: json['url'],
      img: json['img'],
      likes: List<String>.from(json['likes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'genre': genre ?? "",
      'url': url,
      'likes': likes,
      'img': img
    };
  }
}
