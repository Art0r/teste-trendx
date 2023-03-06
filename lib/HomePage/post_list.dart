import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/HomePage/post_item.dart';
import "dart:math";
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PostList extends StatelessWidget {
  List<Post> itens;
  final bool local;
  PostList({super.key, required this.itens, this.local = false});
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.75 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20),
      itemCount: itens.length,
      itemBuilder: (context, index) {

        late Image image;
        if (local) {
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
            child: PostItem(item: itens[index], image: image,),);
      },
    );
  }
}
