import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:patient/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];

  User get currentUser => null;

  String get token => null;

  int get patinet_info => null;
}

class AuthenticationUninitialized extends AuthState {}

class AuthenticationAuthenticated extends AuthState {
  final User user;

  const AuthenticationAuthenticated({@required this.user})
      : assert(user != null);

  @override
  List<Object> get props => [user];

  @override
  User get currentUser => user;

  @override
  String get token => currentUser.token;

  @override
  int get patinet_info => currentUser.patient_info;
}

class AuthenticationUnauthenticated extends AuthState {}

class AuthenticationLoading extends AuthState {}
