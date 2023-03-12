import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/widgets/HomePage/post_item.dart';

class PostList extends StatelessWidget {
  final List<Post> itens;
  final bool test;
  const PostList({super.key, required this.itens, this.test = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: const Key('post_list'),
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.75 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20),
      itemCount: itens.length,
      itemBuilder: (context, index) {
        late Image image;
        if (test) {
          image = Image.file(File('mocks/24f355.png'));
        } else {
          image = Image.network(itens[index].imgUrl);
        }

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(7),
          ),
          child: PostItem(
            item: itens[index],
            image: image,
          ),
        );
      },
    );
  }
}
