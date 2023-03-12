import 'package:flutter/material.dart';
import 'package:trendx/pages/home_page.dart';
import 'package:trendx/services/post_service.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp(
    postService: PostService(http.Client()),
  ));
}

class MyApp extends StatelessWidget {
  final PostService postService;
  const MyApp({super.key, required this.postService});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste Trendx',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(postService: postService),
    );
  }
}
