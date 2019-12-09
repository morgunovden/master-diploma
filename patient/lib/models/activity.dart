import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final String id;
  final String name;

  const Activity({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [
    id,
    name,
  ];

  static Activity fromJson(dynamic json) {
    return Activity(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

