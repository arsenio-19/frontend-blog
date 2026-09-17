import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_blog/main.dart';

void main() {
  testWidgets('Login page tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const myapp());

    expect(find.text('Login'), findsOneWidget);
  });
}