import 'package:flutter/material.dart';
import 'package:trendx/pages/post_page.dart';
import 'package:trendx/classes/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.item, required this.image});
  final Post item;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('post_item'),
      child: Column(
        children: [
          image,
          Center(
            child: Text(
              item.title.substring(0, 10),
              style: const TextStyle(color: Colors.amberAccent, fontSize: 20),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PostPage(item: item)));
      },
    );
  }
}
