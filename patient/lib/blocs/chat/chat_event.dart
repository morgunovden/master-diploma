import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadChatList extends ChatEvent {}
