enum MemberStatus { APPLY, APPROVED, REJECTED }

class ProjectMember {
  final int? id;
  final int projectId;
  final int userId;
  final MemberStatus status;
  final DateTime? appliedAt;
  final DateTime? updatedAt;
  final String? userName;
  final String? userMajor;

  ProjectMember({
    this.id,
    required this.projectId,
    required this.userId,
    required this.status,
    this.appliedAt,
    this.updatedAt,
    this.userName,
    this.userMajor,
  });

  factory ProjectMember.fromJson(Map<String, dynamic> json) {
    return ProjectMember(
      id: json['id'],
      projectId: json['projectId'],
      userId: json['userId'],
      status: MemberStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      appliedAt: json['appliedAt'] != null
          ? DateTime.parse(json['appliedAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      userName: json['userName'],
      userMajor: json['userMajor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'userId': userId,
      'status': status.toString().split('.').last,
    };
  }
}
