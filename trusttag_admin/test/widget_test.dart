import 'package:flutter_test/flutter_test.dart';
import 'package:trusttag_admin/app.dart';

void main() {
  testWidgets('TrustTagAdminApp login entry smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrustTagAdminApp());
    expect(find.text('Welcome Back!'), findsOneWidget);
  });
}
