import 'package:music_app/Models/episode_model.dart';

class Podcast {
  final String id;
  final String title;
  final String? host;
  final String? description;
  final List<Episode>? episodes;
  final String img;

  Podcast({
    required this.id,
    required this.title,
    this.host,
    this.description,
    this.episodes,
    required this.img,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['_id'],
      title: json['title'],
      host: json['host'] ?? "",
      description: json['description'] ?? "",
      episodes: json['episodes'] != null
          ? List<Episode>.from(json['episodes'].map((x) => Episode.fromJson(x)))
          : [],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'host': host,
      'description': description,
      'episodes': episodes,
      'img': img
    };
  }
}
