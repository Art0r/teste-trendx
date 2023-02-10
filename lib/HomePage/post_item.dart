import 'package:flutter/material.dart';
import 'package:trendx/PostPage/post_page.dart';
import 'package:trendx/classes/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.item});
  final Post item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Image.network(
            item.imgUrl,
          ),
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
