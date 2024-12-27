class Song {
  final String id;
  final String title;
  final String artist;
  final String genre;
  final String url;
  final List<String> likes;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.genre,
    required this.url,
    required this.likes,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id'],
      title: json['title'],
      artist: json['artist'],
      genre: json['genre'],
      url: json['url'],
      likes: List<String>.from(json['likes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'genre': genre,
      'url': url,
      'likes': likes,
    };
  }
}
