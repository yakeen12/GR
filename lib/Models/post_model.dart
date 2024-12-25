class Post {
  final String id;
  final String title;
  final String description;
  final String author;
  final String? song;
  final String? podcast;
  final String community;
  final List<String> likes;
  final List<String> comments;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    this.song,
    this.podcast,
    required this.community,
    required this.likes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      song: json['song'],
      podcast: json['podcast'],
      community: json['community'],
      likes: List<String>.from(json['likes']),
      comments: List<String>.from(json['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'song': song,
      'podcast': podcast,
      'community': community,
      'likes': likes,
      'comments': comments,
    };
  }
}
