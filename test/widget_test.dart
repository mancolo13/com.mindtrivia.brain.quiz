import 'package:flutter_test/flutter_test.dart';
import 'package:app8/main.dart';

void main() {
  testWidgets('MindTrivia renders app correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MindTriviaApp());
    expect(find.byType(MindTriviaApp), findsOneWidget);
  });
}
