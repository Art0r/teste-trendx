import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/services/post_service.dart';
import 'package:mocktail/mocktail.dart';

class ClientMock extends Mock implements Client {}

Future<List<Post>> getMockData() async {
  final mockClient = ClientMock();
  final service = PostService(mockClient);

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/posts.json'), 200));

  when(() => mockClient
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos")))
      .thenAnswer((_) async =>
          Response(await rootBundle.loadString('mocks/photos.json'), 200));

  return service.fetchData();
}
