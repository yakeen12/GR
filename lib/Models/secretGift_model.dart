class SecretGift {
  final String id;
  final String sender;
  final String receiver;
  final List<String> songList;
  final DateTime sentAt;

  SecretGift({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.songList,
    required this.sentAt,
  });

  factory SecretGift.fromJson(Map<String, dynamic> json) {
    return SecretGift(
      id: json['_id'],
      sender: json['sender'],
      receiver: json['receiver'],
      songList: List<String>.from(json['songList']),
      sentAt: DateTime.parse(json['sentAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'songList': songList,
      'sentAt': sentAt.toIso8601String(),
    };
  }
}
