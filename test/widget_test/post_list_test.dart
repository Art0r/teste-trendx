import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/widgets/HomePage/post_item.dart';
import 'package:trendx/widgets/HomePage/post_list.dart';
import '../service_mock.dart';

void main() {
  testWidgets('PostList', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    final posts = await getMockData();

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PostList(itens: posts, local: true
        ,),),),);

    expect(find.byType(
        PostItem
    ), findsNWidgets(posts.length));
  });
}