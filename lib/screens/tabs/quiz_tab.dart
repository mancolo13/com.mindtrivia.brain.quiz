import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/storage_service.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  int _currentIdx = 0;
  int _score = 0;
  int? _selectedAns;
  bool _answered = false;

  final List<Map<String, dynamic>> _questions = [
    {
      "q": "What is the speed of light in vacuum?",
      "options": ["300,000 km/s", "150,000 km/s", "450,000 km/s", "1,000,000 km/s"],
      "correct": 0
    },
    {
      "q": "Which planet has the most moons?",
      "options": ["Jupiter", "Saturn", "Mars", "Neptune"],
      "correct": 1
    },
    {
      "q": "Who invented the World Wide Web in 1989?",
      "options": ["Steve Jobs", "Bill Gates", "Tim Berners-Lee", "Alan Turing"],
      "correct": 2
    },
    {
      "q": "What is the hardest natural substance on Earth?",
      "options": ["Gold", "Iron", "Diamond", "Graphene"],
      "correct": 2
    },
  ];

  void _pickAnswer(int idx) {
    if (_answered) return;
    setState(() {
      _selectedAns = idx;
      _answered = true;
      if (idx == _questions[_currentIdx]['correct']) {
        _score += 100;
        int total = StorageService.getInt('trivia_score') + 100;
        StorageService.setInt('trivia_score', total);
      }
    });
  }

  void _next() {
    setState(() {
      _currentIdx = (_currentIdx + 1) % _questions.length;
      _answered = false;
      _selectedAns = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentIdx];
    return Scaffold(
      appBar: AppBar(title: const Text('MindTrivia Arena'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Question ${_currentIdx + 1}/${_questions.length}', style: const TextStyle(color: AppTheme.textSecondary)),
                Text('Score: $_score', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary)),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(q['q'] as String, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            ...(List.generate((q['options'] as List).length, (i) {
              final isCorrect = i == q['correct'];
              final isChosen = i == _selectedAns;
              Color? btnColor;
              if (_answered) {
                if (isCorrect) btnColor = Colors.greenAccent;
                if (isChosen && !isCorrect) btnColor = Colors.redAccent;
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor ?? AppTheme.surface,
                    foregroundColor: btnColor != null ? Colors.black : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => _pickAnswer(i),
                  child: Text(q['options'][i] as String, style: const TextStyle(fontSize: 16)),
                ),
              );
            })),
            const Spacer(),
            if (_answered)
              ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Next Question', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}
