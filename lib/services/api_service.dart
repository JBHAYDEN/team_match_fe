import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/tech_stack.dart';
import '../models/project.dart';
import '../models/project_member.dart';
import '../models/notification.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api'; // 백엔드 URL로 변경

  // 회원가입
  static Future<User> signup(String name, String major) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'major': major}),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('회원가입 실패');
  }

  // 기술스택 저장
  static Future<void> saveTechStacks(
    int userId,
    List<TechStack> techStacks,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tech-stacks/bulk'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'techStacks': techStacks.map((t) => t.toJson()).toList(),
      }),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('기술스택 저장 실패');
    }
  }

  // 사용자 정보 조회
  static Future<User> getUser(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw Exception('사용자 정보 조회 실패');
  }

  // 사용자 기술스택 조회
  static Future<List<TechStack>> getUserTechStacks(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tech-stacks/user/$userId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TechStack.fromJson(json)).toList();
    }
    throw Exception('기술스택 조회 실패');
  }

  // 프로젝트 목록 조회
  static Future<List<Project>> getProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Project.fromJson(json)).toList();
    }
    throw Exception('프로젝트 목록 조회 실패');
  }

  // 프로젝트 생성
  static Future<Project> createProject(Project project) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(project.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Project.fromJson(jsonDecode(response.body));
    }
    throw Exception('프로젝트 생성 실패');
  }

  // 프로젝트 참여 신청
  static Future<void> applyProject(int projectId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/project-members'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'projectId': projectId,
        'userId': userId,
        'status': 'APPLY',
      }),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('참여 신청 실패');
    }
  }

  // 프로젝트 멤버 승인/거절
  static Future<void> updateMemberStatus(
    int memberId,
    MemberStatus status,
  ) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/project-members/$memberId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status.toString().split('.').last}),
    );
    if (response.statusCode != 200) {
      throw Exception('상태 변경 실패');
    }
  }

  // 프로젝트 참여 신청 목록 조회
  static Future<List<ProjectMember>> getProjectApplications(
    int projectId,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/project-members/project/$projectId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProjectMember.fromJson(json)).toList();
    }
    throw Exception('신청 목록 조회 실패');
  }

  // 알림 조회
  static Future<List<NotificationModel>> getNotifications(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/user/$userId'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => NotificationModel.fromJson(json)).toList();
    }
    throw Exception('알림 조회 실패');
  }

  // 알림 읽음 처리
  static Future<void> markNotificationAsRead(int notificationId) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/notifications/$notificationId/read'),
    );
    if (response.statusCode != 200) {
      throw Exception('알림 읽음 처리 실패');
    }
  }
}
