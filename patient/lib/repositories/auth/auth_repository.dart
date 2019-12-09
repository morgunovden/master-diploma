import 'dart:async';
import 'package:meta/meta.dart';

import 'package:patient/repositories/auth/auth_api_client.dart';
import 'package:patient/models/models.dart';

class AuthRepository {
  final AuthApiClient authApiClient;

  AuthRepository({@required this.authApiClient})
    : assert(authApiClient != null);

  Future<User> signup(String email, String password) async {
    return await authApiClient.signup(email: email, password: password);
  }

  Future<User> signin(String email, String password) async {
    return await authApiClient.signin(email: email, password: password);
  }

  Future<void> delete() async {
     return await authApiClient.deleteToken();
  }

  Future<void> persistToken(String token) async {
    return await authApiClient.persistToken(token);
  }

  Future<void> persistId(int id) async {
    return await authApiClient.persistId(id);
  }

  Future<void> persistInfo(User user) async {
    return await authApiClient.persistInfo(user);
  }

  Future<bool> hasToken() async {
    return await authApiClient.hasToken();
  }

  Future<User> getUser() async {
    return await authApiClient.getUser();
  }
}
