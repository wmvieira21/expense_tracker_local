import 'package:expenses_tracker_coursera/utils.dart';

class Category {
  final String id;
  final String name;

  Category(this.name) : id = uuidUtils.v4();
  Category.withId({required this.name, required this.id});

  factory Category.fromJson(dynamic json) {
    return Category.withId(name: json['name'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
