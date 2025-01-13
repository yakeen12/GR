import 'package:music_app/Models/podcast_model.dart';

class Episode {
  final String id;
  final Podcast podcast;
  final String title;
  final String episodeNumber;
  final String description;
  final String audioUrl;

  Episode({
    required this.id,
    required this.podcast,
    required this.title,
    required this.episodeNumber,
    required this.description,
    required this.audioUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['_id'],
      podcast: Podcast.fromJson(json['podcast']),
      title: json['title'],
      episodeNumber: json['episodeNumber'],
      description: json['description'],
      audioUrl: json['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'podcast': podcast,
      'title': title,
      'episodeNumber': episodeNumber,
      'description': description,
      'audioUrl': audioUrl,
    };
  }
}
