class Episode {
  final String id;
  final String podcast;
  final String title;
  final int episodeNumber;
  final String description;
  final String audioUrl;
  final DateTime publishDate;

  Episode({
    required this.id,
    required this.podcast,
    required this.title,
    required this.episodeNumber,
    required this.description,
    required this.audioUrl,
    required this.publishDate,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['_id'],
      podcast: json['podcast'],
      title: json['title'],
      episodeNumber: json['episodeNumber'],
      description: json['description'],
      audioUrl: json['audioUrl'],
      publishDate: DateTime.parse(json['publishDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'podcast': podcast,
      'title': title,
      'episodeNumber': episodeNumber,
      'description': description,
      'audioUrl': audioUrl,
      'publishDate': publishDate.toIso8601String(),
    };
  }
}
