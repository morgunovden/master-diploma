import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String body;
  final String user;

  Message({this.id, this.user, this.body});

  @override
  List<Object> get props => throw UnimplementedError();

  static Message fromJson(dynamic json) {
    return Message(
      id: json['id'].toString(),
      user: json['user'].toString(),
      body: json['body'],
    );
  }
}
