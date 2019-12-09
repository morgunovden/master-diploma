import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:patient/models/patient_info.dart';

class PatientInfoAPiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  PatientInfoAPiClient({
    @required this.httpClient,
  })
    : assert(httpClient != null);

  Future<PatientInfo> updatePatientInfo({
    @required String token,
    @required int id,
    @required String first_name,
    @required String last_name,
    @required String sex,
    @required String birthday,
    @required double weight,
    @required double growth,
    @required int diabetes_type,
  }) async {
    final url = '$baseUrl/patient-info/$id';
    try {
      print(token);
      final response = await this.httpClient.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'first_name': first_name,
          'last_name': last_name,
          'sex': sex,
          'birthday': DateTime.parse(birthday).toIso8601String(),
          'weight': weight,
          'growth': growth,
          'diabetes_type': diabetes_type,
        }),
      );
      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        print('$responseData response');
        if (responseData['message'] is List<dynamic>) {
          throw HttpException(
              responseData['message'][0]['constraints']['matches']);
        }
        throw HttpException(responseData['message']);
      }
      final data = json.decode(response.body);
      return PatientInfo.fromJson(data);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<PatientInfo> getInfo({String token, String id}) async {
    final url = '$baseUrl/patient-info/$id';
    try {
      final response = await httpClient.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode != 200) {
        throw HttpException('Something went wrong');
      }
      final data = jsonDecode(response.body);
      return PatientInfo.fromJson(data);
    } catch(error) {
      throw error;
    }
  }
}
