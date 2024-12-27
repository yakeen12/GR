class Artist {
  final String id;
  final String name;
  final String? image;
  final List<String> songs;

  Artist({
    required this.id,
    required this.name,
    this.image,
    required this.songs,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      songs: List<String>.from(json['songs']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'songs': songs,
    };
  }
}
