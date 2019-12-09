import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Drugs extends Equatable {
  final String id;
  final String name;
  final String type;

  const Drugs({
    @required this.id,
    @required this.name,
    @required this.type,
  });

  @override
  List<Object> get props => [
    id,
    name,
    type,
  ];

  static Drugs fromJson(dynamic json) {
    return Drugs(
      id: json['id'].toString(),
      name: json['name'],
      type: json['type'].toString(),
    );
  }
}
