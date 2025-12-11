import 'package:flutter/material.dart';
import '../models/user.dart';
import 'project_list_screen.dart';
import 'my_projects_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'create_project_screen.dart';

class MainScreen extends StatefulWidget {
  final User currentUser;

  MainScreen({required this.currentUser});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      ProjectListScreen(currentUser: widget.currentUser),
      MyProjectsScreen(currentUser: widget.currentUser),
      NotificationScreen(currentUser: widget.currentUser),
      ProfileScreen(currentUser: widget.currentUser),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: '내 프로젝트'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateProjectScreen(currentUser: widget.currentUser),
                  ),
                ).then((_) => setState(() {}));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
