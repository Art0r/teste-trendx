import 'package:flutter/material.dart';
import '../../classes/post.dart';

class PostPageItem extends StatelessWidget {
  final Post item;
  final Image img;

  const PostPageItem({super.key, required this.item, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('post_page_item'),
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.blueGrey.shade100,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            img,
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                item.body,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 20),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
