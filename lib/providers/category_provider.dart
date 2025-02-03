import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:expenses_tracker_coursera/models/category.dart';

final List<Category> _defultCategories = [
  Category(name: 'Food'),
  Category(name: 'Transport'),
  Category(name: 'Entertainment'),
  Category(name: 'Office'),
  Category(name: 'Gym'),
];

class CategoryProvider extends ChangeNotifier {
  CategoryProvider({required this.storage}) {
    _loadCategoriesLocalStorage();
  }
  LocalStorage storage;
  final List<Category> _categories = [];

  List<Category> get categoriesList {
    return _categories;
  }

  void _loadCategoriesLocalStorage() {
    try {
      var localCategories = localStorage.getItem('categories');
      if (localCategories == null) {
        _categories.addAll(_defultCategories);
      } else {
        _categories.addAll(
          (jsonDecode(localCategories) as List).map((jsonItem) {
            return Category.withId(name: jsonItem['name'], id: jsonItem['id']);
          }),
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error during JSON encoding: $e');
    }
  }

  void addCategory(Category cat) {
    _categories.add(cat);
    saveCategory();
  }

  void deleteCategory(Category cat) {
    _categories.remove(cat);
    saveCategory();
  }

  void saveCategory() {
    try {
      storage.setItem(
        'categories',
        jsonEncode(
          _categories
              .map(
                (category) => category.toJson(),
              )
              .toList(),
        ),
      );
      notifyListeners();
    } catch (e) {
      print('Error during JSON encoding: $e');
    }
  }
}
