import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;
  final User currentUser;

  ProjectDetailScreen({required this.project, required this.currentUser});

  void _applyProject(BuildContext context) async {
    // Mock: 실제로는 API 호출
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('참여 신청이 완료되었습니다 (Mock)')));
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isOwner = project.ownerId == currentUser.id;

    return Scaffold(
      appBar: AppBar(title: Text('프로젝트 상세')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              color: Colors.blue[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('프로젝트 생성자: ${project.ownerName ?? "알 수 없음"}'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '프로젝트 설명',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    project.description,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 24),
                  Text(
                    '필요한 기술',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.requiredTech
                        .map(
                          (tech) => Chip(
                            label: Text(tech),
                            backgroundColor: Colors.blue[100],
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 32),
                  if (isOwner)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('신청 목록 기능은 백엔드 연동 후 사용 가능')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text('신청 목록 보기', style: TextStyle(fontSize: 16)),
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _applyProject(context),
                        child: Text('참여 신청', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
