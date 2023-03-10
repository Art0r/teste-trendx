import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatefulWidget {
  ValueChanged<String> onChanged;

  CustomSearchBar({super.key, required this.onChanged });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      onChanged: widget.onChanged,
    );
  }

}