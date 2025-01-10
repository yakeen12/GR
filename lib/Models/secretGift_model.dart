import 'package:music_app/Models/song_model.dart';

class SecretGift {
  final String id;
  final String receiver;
  final List<Song> songList;
  final DateTime sentAt;

  SecretGift({
    required this.id,
    required this.receiver,
    required this.songList,
    required this.sentAt,
  });

  factory SecretGift.fromJson(Map<String, dynamic> json) {
    return SecretGift(
      id: json['_id'],
      receiver: json['receiver'],
      songList:  List<Song>.from(json['songList'].map((x) => Song.fromJson(x))),
      sentAt: DateTime.parse(json['sentAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiver': receiver,
      'songList': songList,
      'sentAt': sentAt.toIso8601String(),
    };
  }
}
