class Podcast {
  final String id;
  final String title;
  final String host;
  final List<String> genre;
  final String description;
  final List<String> episodes;

  Podcast({
    required this.id,
    required this.title,
    required this.host,
    required this.genre,
    required this.description,
    required this.episodes,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['_id'],
      title: json['title'],
      host: json['host'],
      genre: List<String>.from(json['genre']),
      description: json['description'],
      episodes: List<String>.from(json['episodes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'host': host,
      'genre': genre,
      'description': description,
      'episodes': episodes,
    };
  }
}
