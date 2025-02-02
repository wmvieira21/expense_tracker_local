import 'package:expenses_tracker_coursera/models/tags.dart';
import 'package:flutter/material.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TagbsScreen();
  }
}

class _TagbsScreen extends State<TagsScreen> {
  List<Tag> tagDummyList = [
    Tag(name: 'tag1'),
    Tag(name: 'tag1'),
    Tag(name: 'tag1'),
    Tag(name: 'tag1'),
    Tag(name: 'tag1'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Tags"),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: tagDummyList.length,
          itemBuilder: (context, index) {
            Tag cat = tagDummyList[index];
            return ListTile(
              leading: Icon(Icons.tag),
              title: Text(cat.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {},
              ),
            );
          }),
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
