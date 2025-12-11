import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/project.dart';

class CreateProjectScreen extends StatefulWidget {
  final User currentUser;

  CreateProjectScreen({required this.currentUser});

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  final List<String> availableTechs = [
    'Java',
    'Python',
    'JavaScript',
    'C++',
    'Spring',
    'Django',
    'React',
    'Vue',
    'Flutter',
    'MySQL',
    'MongoDB',
  ];

  List<String> selectedTechs = [];

  void _createProject() async {
    if (_titleController.text.isEmpty ||
        _descController.text.isEmpty ||
        selectedTechs.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('모든 항목을 입력하세요')));
      return;
    }

    // Mock: 실제로는 API 호출
    final project = Project(
      ownerId: widget.currentUser.id!,
      title: _titleController.text,
      description: _descController.text,
      requiredTech: selectedTechs,
    );

    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('프로젝트가 등록되었습니다 (Mock)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('프로젝트 등록')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '프로젝트 제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: '프로젝트 설명',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            Text(
              '필요한 기술스택',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: availableTechs.map((tech) {
                final isSelected = selectedTechs.contains(tech);
                return FilterChip(
                  label: Text(tech),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedTechs.add(tech);
                      } else {
                        selectedTechs.remove(tech);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _createProject,
                child: Text('등록', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
