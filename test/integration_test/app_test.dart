import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/main.dart';
import '../utils/service_mock.dart';

void main() {
  group('Integration Test', () {
    testWidgets('HomePage', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      await tester.pumpWidget(const MyApp(
        test: true,
      ));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('home_page')), findsOneWidget);
    });
  });
}
