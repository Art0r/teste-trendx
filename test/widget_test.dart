import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/HomePage/home_page.dart';
import 'package:trendx/HomePage/post_item.dart';
import 'package:trendx/HomePage/post_list.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/main.dart' as app;
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';
import 'package:trendx/services/post_service.dart';
import 'package:flutter/services.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final mockClient = ClientMock();
  group('Testando os widgets', () {
    testWidgets('- PostItem', (WidgetTester tester) async {
      final service = PostService(mockClient);
      WidgetsFlutterBinding.ensureInitialized();

      when(() => mockClient.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
          .thenAnswer((_) async => Response(await rootBundle.loadString('mocks/posts.json'), 200));

      when(() => mockClient.get(Uri.parse("https://jsonplaceholder.typicode.com/photos")))
          .thenAnswer((_) async => Response(await rootBundle.loadString('mocks/photos.json'), 200));

      final posts = await service.fetchData();

      final postItem = PostItem(item: posts.first,
        image: Image.file(File(posts.first.imgUrl),),);

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: postItem,),),);

      final el = tester.element(find.byWidget(postItem));
      expect(find.byElementPredicate((element) => element == el), findsOneWidget);

    });

    testWidgets('- PostList', (WidgetTester tester) async {
      final service = PostService(mockClient);
      WidgetsFlutterBinding.ensureInitialized();

      when(() => mockClient.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
          .thenAnswer((_) async => Response(await rootBundle.loadString('mocks/posts.json'), 200));

      when(() => mockClient.get(Uri.parse("https://jsonplaceholder.typicode.com/photos")))
          .thenAnswer((_) async => Response(await rootBundle.loadString('mocks/photos.json'), 200));

      final posts = await service.fetchData();

      await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: PostList(itens: posts, local: true
            ,),),),);

      expect(find.byType(
          PostItem
        ), findsNWidgets(posts.length));
      });
  });
}