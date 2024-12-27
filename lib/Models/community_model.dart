class Community {
  final String id;
  final String name;
  final String? description;
  final String creator;
  final List<String> members;

  Community({
    required this.id,
    required this.name,
    this.description,
    required this.creator,
    required this.members,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      creator: json['creator'],
      members: List<String>.from(json['members']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'creator': creator,
      'members': members,
    };
  }
}
