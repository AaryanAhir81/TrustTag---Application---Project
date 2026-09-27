import 'package:flutter_test/flutter_test.dart';
import 'package:trusttag_application/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrustTagApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
