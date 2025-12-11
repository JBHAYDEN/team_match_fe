import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(TeamMatchingApp());
}

class TeamMatchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '팀 매칭 플랫폼',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
