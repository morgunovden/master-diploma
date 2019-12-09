import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:patient/models/models.dart';

class AuthApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;
  final storage = new FlutterSecureStorage();

  AuthApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> signup({
    @required String email,
    @required String password,
  }) async {
    final url = '$baseUrl/auth/signup';
    try {
      final response = await this.httpClient.post(
          url,
          body: json.encode({'email': email, 'password': password, 'type': 'patient'}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }
      );
      if (response.statusCode != 201) {
        final responseData = json.decode(response.body);
        print(responseData);
        if (responseData['message'] is List<dynamic>) {
          throw HttpException(responseData['message'][0]['constraints']['matches']);
        }
        throw HttpException(responseData['message']);
      }
      return await signin(email: email, password: password);
    } catch (error) {
      throw error;
    }
  }

  Future<User> signin({
    @required String email,
    @required String password,
  }) async {
    final url = '$baseUrl/auth/signin';
    try {
      final response = await this.httpClient.post(
          url,
          body: json.encode({'email': email, 'password': password,}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }
      );
      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] is List<dynamic>) {
          throw HttpException(
              responseData['message'][0]['constraints']['matches']);
        }
        throw HttpException(responseData['message']);
      }
      final data = json.decode(response.body);
      return User(
        id: data['userId'],
        token: data['accessToken'],
        filled: data['filled'],
        patient_info: data['patient_info'],
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'id');
    await storage.delete(key: 'filled');
    await storage.delete(key: 'patient_info');
    return;
  }

  Future<void> persistId(int id) async {
    await storage.write(key: 'id', value: id.toString());
    return;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<void> persistInfo(User user) async {
    await storage.write(key: 'id', value: user.id.toString());
    await storage.write(key: 'token', value: user.token);
    await storage.write(key: 'filled', value: user.filled.toString());
    await storage.write(key: 'patient_info', value: user.patient_info.toString());
    return;
  }

  Future<bool> hasToken() async {
    String token = await storage.read(key: 'token');
    return token != null;
  }

  Future<User> getUser() async {
    String token = await storage.read(key: 'token');
    String id = await storage.read(key: 'id');
    String filled = await storage.read(key: 'filled');
    String patient_info = await storage.read(key: 'patient_info');

    if (token == null) return User(
      id: 0,
      token: null,
      filled: false,
      patient_info: null,
    );

    return User(
      id: int.parse(id),
      token: token,
      filled: filled == 'true',
      patient_info: int.parse(patient_info),
    );
  }
}
