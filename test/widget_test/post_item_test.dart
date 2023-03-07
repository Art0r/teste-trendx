import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/HomePage/post_item.dart';
import '../service_mock.dart';

void main() {
  final mockClient = ClientMock();
  testWidgets('PostItem', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    final posts = await getMockData(mockClient);

    final postItem = PostItem(item: posts.first,
      image: Image.file(File(posts.first.imgUrl),),);

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: postItem,),),);

    expect(find.widgetWithText(Column, posts.first.title.substring(0, 10)), findsOneWidget);
    expect(find.widgetWithImage(Column,
        Image.file(File(posts.first.imgUrl)).image), findsOneWidget);
  });
}