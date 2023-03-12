import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trendx/widgets/PostPage/post_page_item.dart';
import '../utils/service_mock.dart';

void main() {
  group('Widgets for the PostPage Test', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('PostPageItem', (WidgetTester tester) async {
      final posts = await getMockData();

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
