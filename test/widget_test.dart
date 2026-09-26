import 'package:flutter_test/flutter_test.dart';
import 'package:recyclo/app/app.dart';

void main() {
  testWidgets('ReCyclo app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ReCycloApp());

    // Verify that the app builds without errors
    expect(find.byType(ReCycloApp), findsOneWidget);

    // Settle splash animations and delay timers
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });
}
