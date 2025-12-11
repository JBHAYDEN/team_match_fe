class TechStack {
  final int? id;
  final int userId;
  final String techName;
  final int skillLevel;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TechStack({
    this.id,
    required this.userId,
    required this.techName,
    required this.skillLevel,
    this.createdAt,
    this.updatedAt,
  });

  factory TechStack.fromJson(Map<String, dynamic> json) {
    return TechStack(
      id: json['id'],
      userId: json['userId'],
      techName: json['techName'],
      skillLevel: json['skillLevel'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'techName': techName, 'skillLevel': skillLevel};
  }
}
