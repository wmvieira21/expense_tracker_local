import 'package:expenses_tracker_coursera/models/tags.dart';
import 'package:expenses_tracker_coursera/providers/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TagbsScreen();
  }
}

class _TagbsScreen extends State<TagsScreen> {
  TextEditingController descTagController = TextEditingController();

  @override
  void dispose() {
    descTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Tag> tagList = Provider.of<TagProvider>(context).tagsList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Tags"),
      ),
      body: Consumer(builder: (context, value, child) {
        return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: tagList.length,
            itemBuilder: (context, index) {
              Tag tag = tagList[index];
              return ListTile(
                leading: Icon(Icons.tag),
                title: Text(tag.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    Provider.of<TagProvider>(context, listen: false)
                        .deleteTag(tag);
                  },
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new tag',
        onPressed: _showAddTagyDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _showAddTagyDialog() {
    var formKey = GlobalKey<FormState>();
    descTagController.clear();

    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text(
          'New Tag',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        content: SizedBox(
          width: 300,
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: descTagController,
              maxLength: 30,
              autofocus: true,
              decoration: InputDecoration(labelText: 'Tag'),
              validator: (value) {
                if (value == '') {
                  return 'Field required';
                }
                return null;
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Provider.of<TagProvider>(context, listen: false)
                    .addTag(Tag(name: descTagController.text));
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
