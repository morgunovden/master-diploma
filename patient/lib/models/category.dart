import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;

  const Category({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [
    id,
    name,
  ];

  static Category fromJson(dynamic json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

