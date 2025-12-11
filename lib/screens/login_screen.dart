import 'package:flutter/material.dart';
import '../models/user.dart';
import 'main_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userIdController = TextEditingController();

  void _login() async {
    // 🎯 Mock 사용자 생성 (서버 없이 테스트)
    final mockUser = User(
      id: 1,
      name: '홍길동',
      major: '컴퓨터공학과',
      createdAt: DateTime.now(),
    );

    // 바로 메인 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(currentUser: mockUser),
      ),
    );
  }

  void _goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.groups, size: 80, color: Colors.blue),
              SizedBox(height: 20),
              Text(
                '팀 매칭 플랫폼',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '(테스트 모드 - 서버 없이 실행)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '아무거나 입력 (테스트용)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: '아무 숫자나 입력하세요',
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text('로그인 (테스트)', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 12),
              TextButton(onPressed: _goToSignup, child: Text('회원가입')),
            ],
          ),
        ),
      ),
    );
  }
}
