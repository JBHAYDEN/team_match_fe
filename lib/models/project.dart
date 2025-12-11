class Project {
  final int? id;
  final int ownerId;
  final String title;
  final String description;
  final List<String> requiredTech;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? ownerName;
  final int? currentMembers;
  final int? maxMembers;

  Project({
    this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.requiredTech,
    this.createdAt,
    this.updatedAt,
    this.ownerName,
    this.currentMembers,
    this.maxMembers,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      ownerId: json['ownerId'],
      title: json['title'],
      description: json['description'],
      requiredTech: (json['requiredTech'] as String)
          .split(',')
          .map((e) => e.trim())
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      ownerName: json['ownerName'],
      currentMembers: json['currentMembers'],
      maxMembers: json['maxMembers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'title': title,
      'description': description,
      'requiredTech': requiredTech.join(', '),
    };
  }
}
