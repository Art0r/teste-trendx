import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trendx/classes/post.dart';
import 'package:trendx/widgets/HomePage/post_list.dart';
import 'package:trendx/services/post_service.dart';
import 'package:trendx/widgets/HomePage/custom_search_field.dart';

class HomePage extends StatefulWidget {
  final PostService postService;
  const HomePage({super.key, required this.postService});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  void getData() async {
    // _itens = await widget.postService.fetchData();
    _itens = await widget.postService.fetchData();
    if (kDebugMode) {
      debugPrint(_itens.toString());
    }
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
      key: const Key('home_page'),
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
                    _searchBar = CustomSearchBar(onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _filteredItens = _itens.where((element) {
                            return element.title.contains(value);
                          }).toList();
                        } else {
                          _filteredItens = List.castFrom(_itens);
                        }
                      });
                    });
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
          future: widget.postService.fetchData(),
          builder: (ctx, snap) {
            if (snap.hasError) {
              return const CircularProgressIndicator();
            }
            if (snap.connectionState == ConnectionState.none ||
                snap.connectionState == ConnectionState.done) {
              if (kDebugMode) {
                debugPrint("ready");
              }
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
