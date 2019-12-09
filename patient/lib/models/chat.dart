import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

enum ChatStatus {
  REQUESTED,
  APPROVED,
  DECLINED,
}

class Chat extends Equatable {
  final String id;
  final ChatStatus status;
  final Doctor doctor;
  final PatientInfo patient;
  final List<Message> messages;

  Chat({this.id, this.status, this.doctor, this.patient, this.messages});

  @override
  List<Object> get props => throw UnimplementedError();

  static Chat fromJson(dynamic json) {
    return Chat(
      id: json['id'].toString(),
      status: EnumToString.fromString(ChatStatus.values, json['status']),
      doctor: Doctor.fromJson(json['doctor']),
      patient: PatientInfo.fromJson(json['patient']),
      messages: json['messages'].map<Message>((message) {
        return Message.fromJson(message);
      }).toList(),
    );
  }
}
