import 'package:flutter/material.dart';
import 'package:trendx/widgets/PostPage/post_page_item.dart';
import '../classes/post.dart';

class PostPage extends StatelessWidget {
  final Post item;
  
  const PostPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Trendx',
          style: TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
        ),
        backgroundColor: Color(Colors.black45.value),
      ),
      body: PostPageItem(item: item)
    );
  }
}
