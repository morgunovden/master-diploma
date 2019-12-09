import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final User user;

  const LoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

class LoggedOut extends AuthEvent {}

