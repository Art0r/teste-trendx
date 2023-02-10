import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trendx/classes/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trendx/HomePage/post_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Icon _myIcon = const Icon(
    Icons.search,
    color: Colors.amber,
  );
  Widget _searchBar = const Text(
    'Trendx',
    style: TextStyle(color: Colors.amber, fontStyle: FontStyle.italic),
  );
  late List<Post> _itens;
  late List<Post> _filteredItens = <Post>[];

  final _random = Random();

  Future<List<Post>> fetchData() async {
    final resPosts =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    final parsedBodyPosts =
        json.decode(resPosts.body).cast<Map<String, dynamic>>();
    final resPhotos = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    final parsedBodyPhotos =
        json.decode(resPhotos.body).cast<Map<String, dynamic>>();
    return parsedBodyPosts
        .map<Post>((item) => Post.fromJson(item,
            parsedBodyPhotos[_random.nextInt(parsedBodyPhotos.length)]["url"]))
        .toList();
  }

  void getData() async {
    _itens = await fetchData();
    _filteredItens = List.castFrom(_itens);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: _searchBar,
        backgroundColor: Color(Colors.black45.value),
        actions: [
          IconButton(
              icon: _myIcon,
              onPressed: () {
                setState(() {
                  if (_myIcon.icon == Icons.search) {
                    _myIcon = _myIcon = const Icon(
                      Icons.cancel,
                      color: Colors.amber,
                    );
                    _searchBar = TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.amber,
                        prefixIconColor: Colors.amber,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar por postagem',
                        hintStyle: TextStyle(color: Colors.amber),
                      ),
                      style: const TextStyle(
                        color: Colors.amber,
                      ),
                      controller: _controller,
                      onChanged: (value) {
                        setState(() {
                          if (_controller.text.isNotEmpty) {
                            _filteredItens = _itens.where((element) {
                              return element.title.contains(_controller.text);
                            }).toList();
                          } else {
                            _filteredItens = List.castFrom(_itens);
                          }
                        });
                      },
                    );
                  } else {
                    _myIcon = const Icon(
                      Icons.search,
                      color: Colors.amber,
                    );
                    _searchBar = const Text(
                      'Trendx',
                      style: TextStyle(
                          color: Colors.amber, fontStyle: FontStyle.italic),
                    );
                    setState(() {
                      _controller.text = "";
                      _filteredItens = List.castFrom(_itens);
                    });
                  }
                });
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<Post>>(
          future: fetchData(),
          builder: (ctx, snap) {
            if (snap.hasError) {
              return CircularProgressIndicator();
            }
            if (snap.connectionState == ConnectionState.done) {
              return PostList(itens: _filteredItens);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      getData();
    });
  }
}
