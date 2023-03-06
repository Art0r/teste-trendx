import 'dart:math';
import 'dart:convert';
import 'package:trendx/classes/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  late http.Client client;

  PostService(this.client);

  Future<List<Post>> fetchData() async {
    final random = Random();
    final resPosts =
    await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    final parsedBodyPosts =
    json.decode(resPosts.body).cast<Map<String, dynamic>>();
    final resPhotos = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    final parsedBodyPhotos =
    json.decode(resPhotos.body).cast<Map<String, dynamic>>();
    return parsedBodyPosts
        .map<Post>((item) => Post.fromJson(item,
        parsedBodyPhotos[random.nextInt(parsedBodyPhotos.length)]["url"]))
        .toList();
  }
}

