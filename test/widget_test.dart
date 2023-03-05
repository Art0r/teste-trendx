import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/main.dart' as app;
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';
import 'package:trendx/services/post_service.dart';
import 'package:flutter/services.dart';

class ClientMock extends Mock implements Client {}

// flutter test test/widget_test.dart -d android -r expanded

void main() {
  final client = ClientMock();

  test("Teste carregamento dos dados: Mock", () async {
    final service = PostService(client);
    WidgetsFlutterBinding.ensureInitialized();

    const app.MyApp();

    when(() => client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
        .thenAnswer((_) async => Response(await rootBundle.loadString('test/mock.json'), 200));

    final posts = await service.fetchData();
    expect(posts, const TypeMatcher<List<Post>>());
  });

  test("Teste carregamento dos dados", () async {
    final service = PostService(Client());
    WidgetsFlutterBinding.ensureInitialized();

    const app.MyApp();

    final posts = await service.fetchData();
    expect(posts, const TypeMatcher<List<Post>>());
  });
}