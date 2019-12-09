import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:patient/helpers/functions.dart';
import 'dart:convert';

import 'package:patient/models/models.dart';

class DiaryApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  DiaryApiClient({@required this.httpClient});

  Future<List<Diary>> fetchDiaryRecords({@required String token, params = const[]}) async {
    String url = '$baseUrl/diary';
    List<Diary> diaryList = [];
    try {
      if (params.length > 0) {
      url += '?${generateParamsString(params)}';
      }
      final response = await this.httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      final diaries = json.decode(response.body);
      for (var diary in diaries) {
        diaryList.add(Diary.fromJson(diary));
      }
      return diaryList;
    } catch (error) {
      throw error;
    }
  }

  Future<void> create({@required String token, @required String record}) async {
    final url = '$baseUrl/diary';
    try {
      final response = await this.httpClient.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: record,
      );
    } catch(error) {
      throw error;
    }
  }
}