import 'dart:io';
import 'package:patient/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class ChatApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  ChatApiClient({this.httpClient});

  Future<List<Chat>> fetch({@required String token}) async {
    String url = '$baseUrl/chat';
    try {
      final response = await httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) {
        throw HttpException('Something went wrong');
      }
      final data = jsonDecode(response.body);
      return data.map<Chat>((item) {
        return Chat.fromJson(item);
      }).toList();
    } catch(error) {
      throw error;
    }
  }
}
