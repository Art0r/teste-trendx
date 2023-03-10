import 'package:flutter/material.dart';
import '../classes/post.dart';

class PostPage extends StatelessWidget {
  Post item;
  PostPage({super.key, required this.item});

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
      body: Container(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Image.network(
                item.imgUrl,
                height: 350,
                width: 350,
              ),
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
      ),
    );
  }
}