import 'package:expenses_tracker_coursera/models/category.dart';
import 'package:expenses_tracker_coursera/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesSreeen extends StatefulWidget {
  const CategoriesSreeen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesScreen();
  }
}

class _CategoriesScreen extends State<CategoriesSreeen> {
  TextEditingController descCategory = TextEditingController();

  @override
  void dispose() {
    descCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories =
        Provider.of<CategoryProvider>(context).categoriesList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Categories"),
      ),
      body: Consumer(builder: (context, value, child) {
        return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category cat = categories[index];
              return ListTile(
                leading: Icon(Icons.category_rounded),
                title: Text(cat.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    Provider.of<CategoryProvider>(context, listen: false)
                        .deleteCategory(cat);
                  },
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new category',
        onPressed: _showAddCategoryDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _showAddCategoryDialog() {
    var formKey = GlobalKey<FormState>();
    descCategory.clear();

    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text(
          'New Category',
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
              controller: descCategory,
              maxLength: 30,
              autofocus: true,
              decoration: InputDecoration(labelText: 'Category'),
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
                Provider.of<CategoryProvider>(context, listen: false)
                    .addCategory(Category(name: descCategory.text));
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
