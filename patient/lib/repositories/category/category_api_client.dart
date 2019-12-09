import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:patient/models/models.dart';

class CategoryApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  CategoryApiClient({
    @required this.httpClient,
  });

  Future<List<Category>> list(
    @required String token,
  ) async {
    final url = '$baseUrl/category';
    List<Category> categoriesList = [];
    try {
      final response = await this.httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      final categories = json.decode(response.body);
      for (var category in categories) {
        categoriesList.add(Category.fromJson(category));
      }
      return categoriesList;
    } catch(error) {
      throw error;
    }
  }

  Future<List<Drugs>> drugs(
    @required String token,
  ) async {
    final url = '$baseUrl/drugs';
    List<Drugs> drugsList = [];
    try {
      final response = await this.httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      final drugs = json.decode(response.body);
      for (var category in drugs) {
        drugsList.add(Drugs.fromJson(category));
      }
      return drugsList;
    } catch(error) {
      throw error;
    }
  }

  Future<List<Activity>> activities(
    @required String token,
  ) async {
    final url = '$baseUrl/activity';
    List<Activity> activitiesList = [];
    try {
      final response = await this.httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      final activities = json.decode(response.body);
      for (var category in activities) {
        activitiesList.add(Activity.fromJson(category));
      }
      return activitiesList;
    } catch(error) {
      throw error;
    }
  }
}