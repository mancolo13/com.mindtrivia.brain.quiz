import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/storage_service.dart';

class RanksTab extends StatelessWidget {
  const RanksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final score = StorageService.getInt('trivia_score');
    return Scaffold(
      appBar: AppBar(title: const Text('IQ Rank & Stats'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.psychology, size: 80, color: AppTheme.primary),
              const SizedBox(height: 16),
              Text('$score PTS', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Rank: Master Quizzer', style: TextStyle(fontSize: 20, color: AppTheme.secondary)),
            ],
          ),
        ),
      ),
    );
  }
}
