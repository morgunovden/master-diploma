import 'package:patient/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => throw UnimplementedError();
}

class InitialChatState extends ChatState {}

class ChatListLoaded extends ChatState {
  final List<Chat> chatList;

  ChatListLoaded({this.chatList});
}

class ChatFailure extends ChatState {
  final String error;

  const ChatFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
