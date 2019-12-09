import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Therapy extends Equatable {
  final String id;
  final String name;

  const Therapy({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [
    id,
    name,
  ];

  static Therapy fromJson(dynamic json) {
    return Therapy(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

