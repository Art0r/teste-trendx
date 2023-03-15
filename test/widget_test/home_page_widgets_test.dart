import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trendx/services/post_service.dart';
import 'package:trendx/widgets/HomePage/custom_search_field.dart';
import 'package:trendx/widgets/HomePage/post_item.dart';
import 'package:trendx/widgets/HomePage/post_list.dart';

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

  group('Widgets for the HomePage Test', () {
    testWidgets('CustomSearchBar', (WidgetTester tester) async {
      handleOnChanged(value) {
        expect(find.text(value), findsOneWidget);
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomSearchBar(onChanged: handleOnChanged),
          ),
        ),
      );

      final textInput = find.byKey(const Key('custom_search_field_key'));

      await tester.tap(textInput);
      await tester.pumpAndSettle();

      String text = "";
      for (String i in 'Ola Mundo'.characters) {
        text += i;
        await tester.enterText(textInput, text);
      }
    });

    testWidgets('PostList and PostItem', (WidgetTester tester) async {
      final postService = PostService(mockClient);
      final posts = await postService.fetchData();

      final postsList = PostList(itens: posts);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: postsList),
        ),
      );

      expect(find.byKey(const Key('post_list')), findsOneWidget);
      expect(find.byKey(const Key('post_item')), findsNWidgets(posts.length));
      expect(find.widgetWithText(PostItem, posts.first.title.substring(0, 10)),
          findsOneWidget);
      expect(find.byType(PostItem), findsNWidgets(posts.length));
      expect(find.image(Image.file(File('mocks/24f355.png')).image),
          findsNWidgets(posts.length));
    });
  });
}
