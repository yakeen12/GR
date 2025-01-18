import 'package:music_app/Models/song_model.dart';

class Artist {
  final String id;
  final String name;
  final String? image;
  final List<Song>? songs;

  Artist({
    required this.id,
    required this.name,
    this.image,
    this.songs,
  });

// // Factory method للتعامل مع الحقل songs سواء كان موجودًا أو غائبًا
//   factory Artist.fromJson(Map<String, dynamic> json) {
//     final dynamic songsData = json['songs']; // قد تكون null

//     List<Song>? parsedSongs; // الحقل يمكن أن يكون null

//     if (songsData is List<Map<String, dynamic>>) {
//       // إذا كانت قائمة من كائنات الأغاني
//       parsedSongs =
//           songsData.map((songJson) => Song.fromJson(songJson)).toList();
//     } else {
//       parsedSongs = [];
//     }

//     return Artist(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'] ?? "",

//       songs: parsedSongs, // قد تكون null
//     );
//   }

  factory Artist.fromJson(Map<String, dynamic> json) {
    // print(" arrrrrrttttttttttt ${json['_id']}");
    // print(" arrrrrrttttttttttt ${json['name']}");

    return Artist(
      id: json['_id'],
      name: json['name'],
      image: json['image'] ?? "",
      songs: json['songs'] != null && json['songs'] is List<dynamic>
          ? List<Song>.from(json['songs'].map((x) => Song.fromJson(x)))
          : [],
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
