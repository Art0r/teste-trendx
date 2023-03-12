import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trendx/services/post_service.dart';
import 'package:trendx/widgets/PostPage/post_page_item.dart';

class ClientMock extends Mock implements Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockClient = ClientMock();

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/posts.json'), 200));

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/photos.json'), 200));

  group('Widgets for the PostPage Test', () {
    testWidgets('PostPageItem', (WidgetTester tester) async {
      final postService = PostService(mockClient);
      final posts = await postService.fetchData();

      final postItem = PostPageItem(
        item: posts.first,
        img: Image.file(
          File(posts.first.imgUrl),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: postItem,
          ),
        ),
      );

      expect(find.byKey(const Key('post_page_item')), findsOneWidget);
      expect(
          find.widgetWithText(PostPageItem, posts.first.title), findsOneWidget);
      expect(
          find.widgetWithText(PostPageItem, posts.first.body), findsOneWidget);
      expect(
          find.widgetWithImage(
              PostPageItem, Image.file(File(posts.first.imgUrl)).image),
          findsOneWidget);
    });
  });
}
