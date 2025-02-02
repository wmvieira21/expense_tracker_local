import 'package:expenses_tracker_coursera/models/category.dart';
import 'package:expenses_tracker_coursera/models/tags.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Category> _categories = [
    Category(name: 'Food'),
    Category(name: 'Transport'),
    Category(name: 'Entertainment'),
    Category(name: 'Office'),
    Category(name: 'Gym'),
  ];
// List of tags
  List<Tag> tags = [
    Tag(name: 'Breakfast'),
    Tag(name: 'Lunch'),
    Tag(name: 'Dinner'),
    Tag(name: 'Treat'),
    Tag(name: 'Cafe'),
    Tag(name: 'Restaurant'),
    Tag(name: 'Train'),
    Tag(name: 'Vacation'),
    Tag(name: 'Birthday'),
    Tag(name: 'Diet'),
    Tag(name: 'MovieNight'),
    Tag(name: 'Tech'),
    Tag(name: 'CarStuff'),
    Tag(name: 'SelfCare'),
    Tag(name: 'Streaming'),
  ];
}
