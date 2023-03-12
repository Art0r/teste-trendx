import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trendx/main.dart';
import 'package:trendx/services/post_service.dart';
import 'package:trendx/widgets/HomePage/post_item.dart';

class ClientMock extends Mock implements Client {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final mockClient = ClientMock();

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/posts.json'), 200));

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/photos.json'), 200));

  group('Integration Test', () {
    testWidgets('HomePage', (WidgetTester tester) async {
      final postService = PostService(mockClient);
      final posts = await postService.fetchData();
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: MyApp(
            postService: PostService(mockClient),
          )),
        ));
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('home_page')), findsOneWidget);
        expect(find.byKey(const Key('post_list')), findsOneWidget);
        expect(find.byKey(const Key('post_item')), findsNWidgets(posts.length));
        expect(find.image(Image.file(File('../mocks/24f355.png')).image),
            findsNWidgets(posts.length));
        expect(
            find.widgetWithText(PostItem, posts.first.title.substring(0, 10)),
            findsOneWidget);
      });
    });
  });
}
