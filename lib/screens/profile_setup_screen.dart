import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/tech_stack.dart';
import 'main_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  final User currentUser;

  ProfileSetupScreen({required this.currentUser});

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final List<String> availableTechs = [
    'Java',
    'Python',
    'JavaScript',
    'C++',
    'C#',
    'Go',
    'Spring',
    'Django',
    'React',
    'Vue',
    'Angular',
    'Flutter',
    'MySQL',
    'PostgreSQL',
    'MongoDB',
    'Oracle',
    'Redis',
  ];

  Map<String, int> selectedTechs = {};

  void _complete() async {
    if (selectedTechs.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('최소 1개 이상의 기술을 선택하세요')));
      return;
    }

    // Mock: 실제로는 API 호출
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(currentUser: widget.currentUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('기술스택 선택'), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '사용 가능한 기술을 선택하고 숙련도를 평가해주세요 (1~5)',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableTechs.length,
              itemBuilder: (context, index) {
                final tech = availableTechs[index];
                final isSelected = selectedTechs.containsKey(tech);
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text(tech),
                    trailing: isSelected
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (selectedTechs[tech]! > 1) {
                                      selectedTechs[tech] =
                                          selectedTechs[tech]! - 1;
                                    }
                                  });
                                },
                              ),
                              Text(
                                '${selectedTechs[tech]}',
                                style: TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    if (selectedTechs[tech]! < 5) {
                                      selectedTechs[tech] =
                                          selectedTechs[tech]! + 1;
                                    }
                                  });
                                },
                              ),
                            ],
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedTechs.remove(tech);
                        } else {
                          selectedTechs[tech] = 3;
                        }
                      });
                    },
                    selected: isSelected,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedTechs.isEmpty ? null : _complete,
                child: Text('완료', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
