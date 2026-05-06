import 'package:flutter_test/flutter_test.dart';
import 'package:nursing_command_center/main.dart';

void main() {
  testWidgets('App launch smoke test', (WidgetTester tester) async {
    // Build our Nursing app and trigger a frame.
    // We use NursingApp() because that is what we named it in main.dart
    await tester.pumpWidget(const NursingApp());

    // Verify that our "COMMAND CENTER" title appears
    expect(find.text('COMMAND CENTER'), findsOneWidget);
  });
}