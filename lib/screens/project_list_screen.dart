import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/project.dart';
import 'project_detail_screen.dart';

class ProjectListScreen extends StatefulWidget {
  final User currentUser;

  ProjectListScreen({required this.currentUser});

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  // Mock 데이터
  List<Project> projects = [
    Project(
      id: 1,
      ownerId: 2,
      title: 'AI 챗봇 개발 프로젝트',
      description: 'GPT API를 활용한 챗봇 서비스',
      requiredTech: ['Python', 'Django', 'React', 'PostgreSQL'],
      ownerName: '김철수',
    ),
    Project(
      id: 2,
      ownerId: 3,
      title: '쇼핑몰 플랫폼 구축',
      description: '풀스택 전자상거래 웹사이트',
      requiredTech: ['Java', 'Spring', 'Vue', 'MySQL'],
      ownerName: '이영희',
    ),
    Project(
      id: 3,
      ownerId: 4,
      title: '모바일 운동 기록 앱',
      description: '운동 루틴 추적 및 분석 앱',
      requiredTech: ['Flutter', 'Firebase', 'MongoDB'],
      ownerName: '박민수',
    ),
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로젝트 찾기'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('새로고침 완료 (Mock 데이터)')));
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                setState(() {});
              },
              child: projects.isEmpty
                  ? Center(child: Text('등록된 프로젝트가 없습니다'))
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        final project = projects[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectDetailScreen(
                                    project: project,
                                    currentUser: widget.currentUser,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    project.description,
                                    style: TextStyle(color: Colors.grey[700]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: project.requiredTech
                                        .map(
                                          (tech) => Chip(
                                            label: Text(
                                              tech,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            backgroundColor: Colors.blue[50],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        project.ownerName ?? '알 수 없음',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
