import 'package:equatable/equatable.dart';
import 'dart:convert';

class University extends Equatable {
  final String id;
  final String name;

  University({this.id, this.name});

  @override
  List<Object> get props => null;

  static University fromJson(dynamic json) {
    return University(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}
