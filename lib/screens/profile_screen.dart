import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/tech_stack.dart';
import 'profile_setup_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User currentUser;

  ProfileScreen({required this.currentUser});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock 기술스택 데이터
  List<Map<String, dynamic>> techStacks = [
    {'name': 'Java', 'level': 4},
    {'name': 'Python', 'level': 5},
    {'name': 'Spring', 'level': 3},
    {'name': 'MySQL', 'level': 4},
  ];

  String _getStarRating(int level) {
    return '★' * level + '☆' * (5 - level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('프로필')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32),
              color: Colors.blue[50],
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      widget.currentUser.name[0],
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.currentUser.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.currentUser.major,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ID: ${widget.currentUser.id}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '보유 기술',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  techStacks.isEmpty
                      ? Text(
                          '등록된 기술이 없습니다',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: techStacks
                              .map(
                                (tech) => Chip(
                                  label: Text(
                                    '${tech['name']} ${_getStarRating(tech['level'])}',
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  SizedBox(height: 24),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('기술스택 수정'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileSetupScreen(
                            currentUser: widget.currentUser,
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('로그아웃'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    },
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
