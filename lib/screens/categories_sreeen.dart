import 'package:expenses_tracker_coursera/models/category.dart';
import 'package:flutter/material.dart';

class CategoriesSreeen extends StatefulWidget {
  const CategoriesSreeen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesScreen();
  }
}

class _CategoriesScreen extends State<CategoriesSreeen> {
  List<Category> categoriesDummyList = [
    Category('category1'),
    Category('category2'),
    Category('category3'),
    Category('category3'),
    Category('category3'),
    Category('category3'),
    Category('category3'),
    Category('category3'),
    Category('category3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Categories"),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: categoriesDummyList.length,
          itemBuilder: (context, index) {
            Category cat = categoriesDummyList[index];
            return ListTile(
              leading: Icon(Icons.category_rounded),
              title: Text(cat.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {},
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new category',
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
