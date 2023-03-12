import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/main.dart' as app;
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';
import 'package:trendx/services/post_service.dart';

// flutter test test/fetch_test.dart -d android -r expanded
class ClientMock extends Mock implements Client {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final mockClient = ClientMock();

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/posts.json'), 200));

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/photos.json'), 200));

  group("Unit tests", () {
    test("- Mock", () async {
      final postService = PostService(mockClient);
      app.MyApp(
        postService: postService,
      );

      final posts = await postService.fetchData();
      expect(posts, const TypeMatcher<List<Post>>());
    });
  });
}
