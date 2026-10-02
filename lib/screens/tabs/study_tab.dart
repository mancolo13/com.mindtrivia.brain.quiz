import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class StudyTab extends StatelessWidget {
  const StudyTab({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'title': 'World Cup Records', 'desc': 'Historical champions and top goalscorers.'},
      {'title': 'Olympic Legends', 'desc': 'Track, field, and swimming milestone moments.'},
      {'title': 'Grand Slam Champions', 'desc': 'Key statistics across major tennis opens.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Trivia Knowledge Base'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (ctx, i) {
          final t = topics[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.menu_book_rounded, color: AppTheme.primary),
              title: Text(t['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(t['desc'] as String),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
