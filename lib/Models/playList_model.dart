import 'package:music_app/Models/song_model.dart';

class Playlist {
  String id;
  String name;
  bool isPublic;
  bool allowEditing;
  List<Song> songs;
  // User createdBy;
  String createdBy;

  Playlist({
    required this.id,
    required this.name,
    this.isPublic = true,
    this.allowEditing = false,
    required this.songs,
    required this.createdBy,
  });

  // تحويل JSON إلى كائن Playlist
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['_id'],
      name: json['name'],
      isPublic: json['isPublic'] ?? true,
      allowEditing: json['allowEditing'] ?? false,
      songs: List<Song>.from(json['songs'].map((x) => Song.fromJson(x))),
      // createdBy: User.fromJson(json['createdBy']),
      createdBy: json['createdBy'],
    );
  }

  // تحويل كائن Playlist إلى JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'isPublic': isPublic,
      'allowEditing': allowEditing,
      'songs': songs.map((x) => x.toJson()).toList(),
      // 'createdBy': createdBy.toJson(),
      "createdBy": createdBy
    };
  }
}
