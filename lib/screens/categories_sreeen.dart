import 'package:flutter/material.dart';

class CategoriesSreeen extends StatefulWidget {
  const CategoriesSreeen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesScreen();
  }
}

class _CategoriesScreen extends State<CategoriesSreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Categories"),
      ),
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
