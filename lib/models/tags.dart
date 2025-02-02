import 'package:expenses_tracker_coursera/utils.dart';

class Tag {
  final String id;
  final String name;

  Tag({
    required this.name,
  }) : id = uuidUtils.v4();
  Tag.withId({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag.withId(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
