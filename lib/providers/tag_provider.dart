import 'dart:convert';
import 'package:expenses_tracker_coursera/models/tags.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

final List<Tag> _defaultTags = [
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

class TagProvider extends ChangeNotifier {
  TagProvider({required this.storage}) {
    _loadTagsLocalStorage();
  }

  LocalStorage storage;
  final List<Tag> _tags = [];

  List<Tag> get tagsList {
    return _tags;
  }

  void _loadTagsLocalStorage() {
    try {
      var localTags = localStorage.getItem('tags');
      if (localTags == null) {
        _tags.addAll(_defaultTags);
      } else {
        _tags.addAll(
          (jsonDecode(localTags) as List).map((jsonItem) {
            return Tag.withId(name: jsonItem['name'], id: jsonItem['id']);
          }),
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error during JSON encoding: $e');
    }
  }

  void addTag(Tag cat) {
    _tags.add(cat);
    saveTag();
  }

  void deleteTag(Tag cat) {
    _tags.remove(cat);
    saveTag();
  }

  void saveTag() {
    try {
      storage.setItem(
        'tags',
        jsonEncode(
          tagsList
              .map(
                (tag) => tag.toJson(),
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
