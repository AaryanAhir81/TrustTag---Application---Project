import 'package:flutter_test/flutter_test.dart';
import 'package:trusttag_application/src/app.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TrustTagApp());

    // Verify that Splash Screen is shown
    expect(find.textContaining('Trust'), findsAtLeast(1));
    expect(find.textContaining('Tag'), findsAtLeast(1));
    expect(find.textContaining('Initializing'), findsOneWidget);
  });
}
