import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class DiabetesType extends Equatable {
  final String id;
  final String name;

  const DiabetesType({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [
    id,
    name,
  ];

  static DiabetesType fromJson(dynamic json) {
    return DiabetesType(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

