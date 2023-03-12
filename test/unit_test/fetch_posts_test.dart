import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/main.dart' as app;
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';
import '../utils/service_mock.dart';

class ClientMock extends Mock implements Client {}

// flutter test test/fetch_test.dart -d android -r expanded

void main() {
  group("Unit tests", () {
    test("- Mock", () async {
      WidgetsFlutterBinding.ensureInitialized();

      const app.MyApp();

      final posts = await getMockData();
      expect(posts, const TypeMatcher<List<Post>>());
    });
  });
}