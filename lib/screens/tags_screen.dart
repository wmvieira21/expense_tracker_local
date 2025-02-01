import 'package:flutter/material.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TagbsScreen();
  }
}

class _TagbsScreen extends State<TagsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Tags"),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new tag',
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
